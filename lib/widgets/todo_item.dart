// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isLongPressed = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isLongPressed) {
          setState(() {
            isLongPressed = false;
          });
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            isLongPressed = true;
          });
        },
        onTap: () {
          setState(() {
            isLongPressed = false;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            isThreeLine: true, 
            onTap: () => context.read<TodoCubit>().toggleIsDone(widget.todo.iD),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            tileColor: const Color(0xFFF5F7F9),
            leading: IconButton(
              icon: Icon(
                widget.todo.isDone
                    ? Icons.check_box_rounded
                    : Icons.check_box_outline_blank_rounded,
                color: const Color(0xFFC6CFDC),
                size: 30,
              ),
              onPressed: () =>
                  context.read<TodoCubit>().toggleIsDone(widget.todo.iD),
            ),
            trailing: isLongPressed
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => context.read<TodoCubit>().deleteTodo(widget.todo.iD),
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFC6CFDC)),
                    onPressed: () => context.go('/details/${widget.todo.iD}'),
                  ),
            title: Text(
              widget.todo.todoTitle,
              style: TextStyle(
                color: isLongPressed ? const Color(0xFF8D9CB8) : Colors.black,
                fontSize: 18,
              ),
            ),
            subtitle: widget.todo.todoSubtitle != null
              ? Text(
                  widget.todo.todoSubtitle!,
                  style:
                      const TextStyle(color: Color(0xFF8D9CB8), fontSize: 16),
                )
              : null,
          ),
        ),
      ),
    );
  }
}
