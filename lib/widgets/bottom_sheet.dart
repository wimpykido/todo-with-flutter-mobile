import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';

class CustomBottomSheet extends StatefulWidget {
  final Todo? initialTodo;

  const CustomBottomSheet({
    super.key,
    this.initialTodo,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {});
    subtitleController.addListener(() {});
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.check_box_outline_blank_rounded,
                color: Color(0xFFC6CFDC),
                size: 30,
              ),
              border: InputBorder.none,
              labelText: "What's on your mind?",
              labelStyle: TextStyle(
                fontSize: 20,
                color: Color(0xFFC6CFDC),
              ),
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: subtitleController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.edit,
                color: Color(0xFFC6CFDC),
                size: 30,
              ),
              border: InputBorder.none,
              labelText: "Add a note",
              labelStyle: TextStyle(
                fontSize: 20,
                color: Color(0xFFC6CFDC),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.read<TodoCubit>().addTodo(
                  todoTitle: titleController.text.trim(),
                  todoSubtitle: subtitleController.text.trim()),
              child: const Text(
                "Create",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
