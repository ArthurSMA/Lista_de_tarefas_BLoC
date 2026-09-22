import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/materials/task.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  // Estado Inicial: Instancia o TaskState com uma lista de tarefas vazia
  TaskBloc(): super(const TaskState(tasks: [])) {

    on<AddTaskEvent>((event, emit) {
      if (event.title.trim().isEmpty)  return;

      // Cria a nova tarefa com status inicial padrão (pending)
      final newTask = Task(
        title: event.title.trim(),
        status: TaskStatus.pending,
      );

      // Instancia uma nova lista a partir da lista atual e adiciona a nova tarefa
      final updateList = List<Task>.from(state.tasks)..add(newTask);

      // Emite um novo estado com a lista atualizada
      emit(state.copyWith(tasks: updateList));
    });

    on<RemoveTaskEvent>((event, emit) {
      // Clona a lista atual
      final updateList = List<Task>.from(state.tasks);

      // Garante que o índice recebido seja válido antes de remover
      if (event.index >= 0 && event.index < updateList.length) {
        updateList.removeAt(event.index);

        // Emite o novo estado com o item removido
        emit(state.copyWith(tasks: updateList));
      }
    });

    on<UpdateTaskStatusEvent>((event, emit) {
      final updateList = List<Task>.from(state.tasks);

      if (event.index >= 0 && event.index < updateList.length) {
        // Obtém a tarefa atual do índice
        final currentTask = updateList[event.index];

        // Atualiza o item no índice com uma nova instância contendo o novo status
        updateList[event.index] = Task(
          title: currentTask.title,
          status: event.newStatus
        );

        // Emite a nova lista atualizada
        emit(state.copyWith(tasks: updateList));
      }
    });
  }
}
