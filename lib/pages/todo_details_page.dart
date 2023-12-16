import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';

class TodoDetails extends StatelessWidget {
  final String todoId;
  const TodoDetails({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    final todo = todoCubit.state.firstWhere((todo) => todo.iD == todoId);
    String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm a').format(todo.createdAt!);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            todo.todoTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                formattedDateTime,
                style: const TextStyle(fontSize: 10, color: Color(0xFF8D9CB8)),
              ),
              const SizedBox(width: 25,),
              Text(
                todo.isDone ? "completed" : "not completed",
                style: const TextStyle(fontSize: 10, color: Color(0xFF8D9CB8)),
              ),
            ],
          ),
          const SizedBox(height: 50,),
          Text(todo.todoSubtitle!),
        ]),
      ),
    );
  }
}
