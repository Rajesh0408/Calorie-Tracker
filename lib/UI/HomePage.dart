import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color card = const Color(0xFFe0c3fc);
  Color appbar = const Color(0xFF7b2cbf);
  int? height;
  int? weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Calorie Tracker For Indian Food'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {

          }, child: const Text('Start the journey of Calorie'))
        ],
      ),
    );
  }
}
