import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quit_17_app/home.dart';
import 'package:quit_17_app/view/addItem.dart';
import 'package:quit_17_app/view/detailItem.dart';

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
        GetPage(name: '/add', page: ()=>AddItem()),
        GetPage(name: '/detail', page: ()=>DetailItem()),
        
      ],
    );
  }
}

