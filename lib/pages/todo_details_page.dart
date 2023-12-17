import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';

class TodoDetails extends StatefulWidget {
  const TodoDetails({super.key, required this.todoId});
  final String todoId;

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  late TextEditingController titleController;
  late TextEditingController subtitleController;
  bool isEditable = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    subtitleController = TextEditingController();
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    final todo = todoCubit.state.firstWhere((todo) => todo.iD == widget.todoId);
    titleController.text = todo.todoTitle;
    subtitleController.text = todo.todoSubtitle!;
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    final todo = todoCubit.state.firstWhere((todo) => todo.iD == widget.todoId);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd hh:mm a').format(todo.createdAt!);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          isEditable
              ? IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                      Todo updatedTodo = todo.copyWith(
                        todoTitle: titleController.text,
                        todoSubtitle: subtitleController.text,
                      );
                      todoCubit.updateTodo(updatedTodo);
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isCollapsed: true,
                ),
                enabled: isEditable,
                // initialValue: todo.todoTitle,
                textInputAction: TextInputAction.done,
                controller: titleController,
                onFieldSubmitted: (value) {
                  setState(() {
                    isEditable = false;
                    Todo updatedTodo = todo.copyWith(todoTitle: value);
                    print(todoCubit.state);
                    todoCubit.updateTodo(updatedTodo);
                  });
                },
              ),
              Row(
                children: [
                  Text(
                    formattedDateTime,
                    style:
                        const TextStyle(fontSize: 10, color: Color(0xFF8D9CB8)),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    todo.isDone ? "completed" : "not completed",
                    style:
                        const TextStyle(fontSize: 10, color: Color(0xFF8D9CB8)),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 10, color: Color(0xFF8D9CB8)),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    hintText: "start typing"),
                enabled: isEditable,
                // initialValue: todo.todoSubtitle ?? "",
                textInputAction: TextInputAction.done,
                controller: subtitleController,
                onFieldSubmitted: (value) {
                  setState(() {
                    isEditable = false;
                    print(todoCubit.state);
                    Todo updatedTodo = todo.copyWith(todoSubtitle: value);
                    todoCubit.updateTodo(updatedTodo);
                  });
                },
              ),
            ]),
      ),
    );
  }
}
