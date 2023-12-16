// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        isThreeLine: true,
        onTap: () => context.read<TodoCubit>().toggleIsDone(todo.iD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: const Color(0xFFF5F7F9),
        leading: IconButton(
          icon: Icon(
            todo.isDone
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
            color: const Color(0xFFC6CFDC),
            size: 30,
          ),
          onPressed: () => context.read<TodoCubit>().toggleIsDone(todo.iD),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFC6CFDC)),
          onPressed: () => context.go('/details/${todo.iD}'),
        ),
        title: Text(
          todo.todoTitle,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        subtitle: Text(
          todo.todoSubtitle ?? '',
          style: const TextStyle(color: Color(0xFF8D9CB8), fontSize: 16),
        ),
      ),
    );
  }
}
