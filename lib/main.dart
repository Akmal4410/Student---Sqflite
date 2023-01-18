import 'package:flutter/material.dart';
import 'package:student_mannagement_sqflite/controller/db_functions.dart';
import 'package:student_mannagement_sqflite/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBFunction.openMyDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Manegment Sqflite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
