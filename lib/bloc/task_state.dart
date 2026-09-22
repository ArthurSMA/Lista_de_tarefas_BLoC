import 'package:todo_bloc/materials/task.dart';

// BLoC (State): Representa a "fotografia" dos dados da tela em um determinado momento.
// Os campos são imutáveis (`final`) para garantir previsibilidade nas reações da UI.
class TaskState {
  // A lista atual de tarefas que a interface gráfica (UI) deve exibir.
  final List<Task> tasks;
  
  // Flag que indica à UI se deve exibir um indicador de carregamento.
  final bool isLoading;

  // Construtor de estado. Define valores padrões (ex: 'isLoading' como 'false')
  const TaskState({
    required this.tasks,
    this.isLoading = false
  });

  // Método utilitário para criar um NOVO objeto de estado a partir do atual.
  /* Como o estado é imutável, o BLoC usa o 'copyWith' para modificar apenas os campos 
  necessários (usando o operador '??') mantendo os dados anteriores no restante. */
  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks, 
      isLoading: isLoading ?? this.isLoading
      );
  }
}
