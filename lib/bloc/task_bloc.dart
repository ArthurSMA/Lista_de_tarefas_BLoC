import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/task_dao.dart';
import 'package:todo_bloc/materials/task.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskDao _taskDao = TaskDao();

  TaskBloc() : super(TaskState(tasks: [])) {
    // Carregar tarefas do banco de dados ao iniciar
    on<LoadTaskEvent>((event, emit) async {
      final tasks = await _taskDao.findAll();
      emit(TaskState(tasks: tasks));
    });

    // Adicionar tarefa no SQLite
    on <AddTaskEvent>((event, emit) async {
      final newTask = Task(
        title: event.title, 
        status: TaskStatus.pending
      );
      await _taskDao.save(newTask);
      final updateTask = await _taskDao.findAll();
      emit(TaskState(tasks: updateTask));
    });

    // Atualiza o estado da tarefa no SQLite
    on <UpdateTaskStatusEvent>((event, emit) async {
      final task = state.tasks[event.index];
      final updateTask = Task(
        id: task.id,
        title: task.title,
        status: task.status,
      );
      await _taskDao.save(updateTask);
      final updatedTask = await _taskDao.findAll();
      emit(TaskState(tasks: updatedTask));
    });

    on<RemoveTaskEvent>((event, emit) async {
      final task = state.tasks[event.index];
      if (task.id != null) {
        await _taskDao.deleteById(task.id!); // ! operador de asserção não-nula
      }
      final updatedTask = await _taskDao.findAll();
      emit(TaskState(tasks: updatedTask));
    });
  }
}
