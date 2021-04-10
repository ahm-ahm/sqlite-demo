import 'package:db_final/home_todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.dark,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: HomeTodo(),
    );
  }
}
