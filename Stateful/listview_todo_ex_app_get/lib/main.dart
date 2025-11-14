import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:listview_todo_ex_app_get/view/product/detail.dart';
import 'package:listview_todo_ex_app_get/view/product/insert.dart';
import 'package:listview_todo_ex_app_get/view/product/list.dart';
import 'package:listview_todo_ex_app_get/view/product/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: [
        GetPage(name: '/', page:()=>ProductList()),
        GetPage(name: '/detail', page:()=>ProductDetail()),
        GetPage(name: '/update', page:()=>ProductUpdate()),
        GetPage(name: '/insert', page:()=>ProductInsert()),
      ],
   
    );
  }
}
