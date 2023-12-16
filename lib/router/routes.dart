import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_with_cubit/cubit/todo_cubit.dart';
import 'package:todo_with_cubit/pages/todo_details_page.dart';
import 'package:todo_with_cubit/pages/todo_list_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); 
final _router = GoRouter(navigatorKey: navigatorKey,routes: [
  GoRoute(path: '/', builder: (context, state) => TodoList()),
  GoRoute(
    path: '/details/:id',
    builder: (context, state) {
      return TodoDetails(todoId: state.pathParameters['id']!);
    },
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit(),
      child: MaterialApp.router(
        title: 'todo app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}
