import 'package:todo_bloc/materials/task.dart';

// BLoC (Event)

// Classe abstrata base que representa as entradas (ações do usuário/sistema) no BLoC.
abstract class TaskEvent {
  const TaskEvent();
}

// Solicita o carregamento inicial de todas as tarefas salvas no SQLite.
// Não precisa de nenhum parâmetro, pois a busca traŕa todos os registros.
class LoadTaskEvent extends TaskEvent {
   const LoadTaskEvent();
}

// Solicita a adição de uma nova tarefa.
// Carrega como payload o título informado na UI.
class AddTaskEvent extends TaskEvent {
  final String title;

  const AddTaskEvent(this.title);
}

// Solicita a remoção de uma tarefa.
// Carrega como payload o índice do item a ser removido.
class RemoveTaskEvent extends TaskEvent {
  final int index;

  const RemoveTaskEvent(this.index);
}

// Solicita a alteração do status de uma tarefa.
// Carrega como payload o índice do item e o novo status a ser processado pela lógica do BLoC.
class UpdateTaskStatusEvent extends TaskEvent { 
  final int index;
  final TaskStatus newStatus;

  const UpdateTaskStatusEvent({
    required this.index,
    required this.newStatus
  });
}
