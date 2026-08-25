import 'package:flutter/material.dart';

void main() {
  runApp(const InternHupApp());
}

class InternHupApp extends StatelessWidget {
  const InternHupApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: Center(child: Text('Hello World'))),
    );
  }
}
