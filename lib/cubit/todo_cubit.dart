import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoCubit extends Cubit<List<Todo>> {
  late List<Todo> originalTodos;
  TodoCubit() : super([]) {
    originalTodos = [];
  }

  void addTodo({String? todoTitle, String? todoSubtitle}) {
    const uuid = Uuid();
    final newTodo = Todo(
        iD: uuid.v4(),
        todoTitle: todoTitle!,
        todoSubtitle: todoSubtitle,
        createdAt: DateTime.now(),
        isDone: false);
    state.add(newTodo);
    emit([...state]);
    originalTodos = [...state];
  }

  void toggleIsDone(String todoId) {
    final updatedList = state.map((todo) {
      return todo.iD == todoId ? todo.copyWith(isDone: !todo.isDone) : todo;
    }).toList();

    emit(updatedList);
    originalTodos = [...state];
  }

  void searchTodo(String query) {
    List<Todo> updatedList = [];
    if (query.isEmpty) {
      updatedList = originalTodos;
    } else {
      updatedList = originalTodos.where((todo) {
        return todo.todoTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(updatedList);
  }
  //removeTodo
  //editTodo
}
