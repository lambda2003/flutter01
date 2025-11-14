import 'package:flutter/material.dart';
import 'package:image_ex_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Ex Demo',
      theme: ThemeData(
        // 전체 컬러를 변경 할수 있게 하기 위해 나옴.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}

