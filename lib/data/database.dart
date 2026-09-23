import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './task_dao.dart';

// Padrão singleton: Garante que a classe tenha apenas uma única instância durante 
// toda a execução do aplicativo e fornece um ponto de acesso global para ela.
class DatabaseHelper {
  // 1. Guarda a única instância aberta em memória
  static Database? _database;

  // Construtor privado para evitar chamadas acidentais como DatabaseHelper()
  DatabaseHelper._internal();

  // 2. Getter estático assíncrono que gerencia a conexão
  static Future<Database> get database  async {
    // Se a conexão já existe e está aberta, reutiliza a mesma
    if (_database != null) return _database!;

    // Se for a primeira vez, abre o banco e salva em _database
    _database = await _initDatabase();
    return _database!;
  }

  // Método interno responsável por abrir/criar o arquivo físico .db
  static Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'task.db');
    return openDatabase(path, onCreate: (db, version){
      db.execute(TaskDao.tableSql);
      }, version: 1
    );
  }
}
