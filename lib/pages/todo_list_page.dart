import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';
import 'package:todo_with_cubit/widgets/bottom_sheet.dart';
import 'package:todo_with_cubit/widgets/no_tasks.dart';
import 'package:todo_with_cubit/widgets/search_bar.dart';
import 'package:todo_with_cubit/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "todo app",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Tasks",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SearchBox(),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: BlocBuilder<TodoCubit, List<Todo>>(
                  builder: (context, todos) {
                    return todos.isEmpty
                        ? const NoTasks()
                        : ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return TodoItem(todo: todo);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const CustomBottomSheet();
            },
          )
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
