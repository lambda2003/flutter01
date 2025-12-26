import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_list_app/firebase_options.dart';
import 'package:firebase_list_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  // GT: stream을 받아서 계속 async되야 하기 때문에 async
  // Firebase 인증
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home()
    );
  }
}
