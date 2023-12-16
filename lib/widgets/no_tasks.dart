import 'package:flutter/widgets.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/no.png'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "You have no task listed",
          style: TextStyle(color: Color(0xFF8D9CB8), fontSize: 19),
        ),
      ],
    ));
  }
}
