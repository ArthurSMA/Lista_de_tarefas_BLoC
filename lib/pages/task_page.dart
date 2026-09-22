import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/materials/task.dart';

import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa adicionada'));
          }

          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];

              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.status == TaskStatus.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: Checkbox(
                  value: task.status == TaskStatus.done,
                  onChanged: (bool? isChecked) {
                    final newStatus = (isChecked ?? false)
                      ? TaskStatus.done
                      : TaskStatus.pending;
                    
                    taskBloc.add(
                      UpdateTaskStatusEvent(
                        index: index, 
                        newStatus: newStatus
                      ),
                    );
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    taskBloc.add(RemoveTaskEvent(index));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Nova Tarefa'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite o título da tarefa',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      taskBloc.add(AddTaskEvent(controller.text));
                      controller.clear();
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
