import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoApp extends StatefulWidget {
  const AddTodoApp({Key? key}) : super(key: key);

  @override
  _AddTodoApp createState() => _AddTodoApp();
}

class _AddTodoApp extends State<AddTodoApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo 추가'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
