import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/data/database.dart';
import 'package:todo_bloc/materials/task.dart';

class TaskDao {
  // Nomes das colunas e tabela
  static const String _tablename = 'taskTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _status = 'status';

  // Script DDL de criação de tabela com AUTOINCREMENT na Chave Primária
  static const String tableSql = '''
    CREATE TABLE $_tablename (
      $_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_name TEXT NOT NULL,
      $_status TEXT NOT NULL 
    )
  ''';

  /// Insere ou atualiza uma tarefa no banco de dados.
  /// Retorna um [Future<int>] contendo o ID inserido ou a quantidade de linhas alteradas.
  Future<int> save(Task tarefa) async {
    print('Iniciando o save:');
    final Database bancoDeDados = await getDatabase();
    final Map<String, dynamic> taskMap = toMap(tarefa);

    if (tarefa.id == null) {
      print('A tarefa não existia, inserindo nova...');
      return await bancoDeDados.insert(
        _tablename,
        taskMap,
      );
    } else {
      print('A tarefa já existe (ID: ${tarefa.id}), atualizando...');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_id = ?',
        whereArgs: [tarefa.id],
      );
    }
  }

  /// Converte um objeto [Task] em [Map<String, dynamic>] compatível com o SQFlite.
  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo Tarefa em Map:');
    final Map<String, dynamic> mapaDeTarefas = {};

    if (tarefa.id != null) {
      mapaDeTarefas[_id] = tarefa.id;
    }
    mapaDeTarefas[_name] = tarefa.title;
    mapaDeTarefas[_status] = tarefa.status.name; // Converte o Enum em String

    print('Mapa de Tarefas gerado: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  /// Busca todas as tarefas gravadas no banco de dados.
  Future<List<Task>> findAll() async {
    print('Acessando o findAll...');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename);
    print('Procurando dados no banco... encontrado: $result');
    return toList(result);
  }

  /// Converte a lista de Maps do SQFlite para uma lista de objetos [Task].
  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo Map para Lista de tarefas:');
    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final String statusString = linha[_status];
      final TaskStatus statusEnum = TaskStatus.values.firstWhere(
        (e) => e.name == statusString,
        orElse: () => TaskStatus.pending,
      );

      final Task tarefa = Task(
        id: linha[_id] as int?,
        title: linha[_name] as String,
        status: statusEnum,
      );

      tarefas.add(tarefa);
    }

    print('Lista de Tarefas tratada: $tarefas');
    return tarefas;
  }

  /// Busca tarefas pelo nome/título.
  Future<List<Task>> find(String nomeTarefa) async {
    print('Procurando tarefas com o nome: $nomeTarefa');
    final Database bancoDeDados = await getDatabase();

    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeTarefa],
    );

    final List<Task> tarefasEncontradas = toList(result);
    print('Tarefa(s) encontrada(s): $tarefasEncontradas');
    return tarefasEncontradas;
  }

  /// Deleta a tarefa pelo seu ID (Chave Primária).
  Future<int> deleteById(int id) async {
    print('Deletando a tarefa com ID: $id');
    final Database bancoDeDados = await getDatabase();

    return await bancoDeDados.delete(
      _tablename,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  /// Deleta a tarefa pelo seu nome/título.
  Future<int> deleteByName(String nomeTarefa) async {
    print('Deletando tarefa: $nomeTarefa');
    final Database bancoDeDados = await getDatabase();

    return await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeTarefa],
    );
  }
}
