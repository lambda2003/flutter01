import 'package:flutter/material.dart';
import 'package:listview_todo_ex_app/view/product/detail.dart';
import 'package:listview_todo_ex_app/view/product/insert.dart';
import 'package:listview_todo_ex_app/view/product/list.dart';
import 'package:listview_todo_ex_app/view/product/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context)=> ProductList(),
        '/detail' : (context)=> ProductDetail(),
        '/update' : (context)=> ProductUpdate(),
        '/insert' : (context)=> ProductInsert(),
      },
    );
  }
}
