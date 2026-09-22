import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/task_bloc.dart';
import 'package:todo_bloc/bloc/task_event.dart';
import 'package:todo_bloc/pages/task_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App BLoC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Instancia e provê o TaskBloc para toda a árvore abaixo da TaskPage
      home: BlocProvider(
        create: (context) => TaskBloc()..add(const LoadTaskEvent()), // <--- Dispara a busca ao iniciar
        child: const TaskPage(),
      ),
    );
  }
}
