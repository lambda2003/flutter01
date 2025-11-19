import 'package:collection_view_label_app/view/detail.dart';
import 'package:collection_view_label_app/view/edit.dart';
import 'package:collection_view_label_app/view/home.dart';
import 'package:collection_view_label_app/view/insert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>Home()),
        GetPage(name: '/insert', page: ()=>Insert()),
        GetPage(name: '/detail', page: ()=>Detail()),
        GetPage(name: '/edit', page: ()=>Edit())
      ],
      // home: const Home(),
    );
  }
}
