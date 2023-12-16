import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/models/todo.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late FocusNode _searchFocusNode;
  late TextEditingController _searchController;
  late TodoCubit _todoCubit;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController();
    _todoCubit = context.read<TodoCubit>();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, List<Todo>>(
      builder: (context, todoList) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  _searchFocusNode.hasFocus ? Colors.blue : Color(0xFFC6CFDC),
              width: 2.0,
            ),
          ),
          child: TextField(
            focusNode: _searchFocusNode,
            controller: _searchController,
            onChanged: (value) {
              _todoCubit.searchTodo(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color:
                    _searchFocusNode.hasFocus ? Colors.blue : Color(0xFFC6CFDC),
                size: 20,
              ),
              border: InputBorder.none,
              labelText: 'Search task',
            ),
          ),
        );
      },
    );
  }
}
