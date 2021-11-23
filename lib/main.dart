import 'package:flutter/material.dart';
import 'package:fundamental2/ui/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MainScreen(),
    );
  }
}
