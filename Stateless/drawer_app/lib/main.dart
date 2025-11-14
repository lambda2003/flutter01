import 'package:drawer_app/home.dart';
import 'package:drawer_app/view/receive_mail_box.dart';
import 'package:drawer_app/view/send_mail_box.dart';
import 'package:flutter/material.dart';

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
        '/' : (context) => Home(),
        '/send_page' : (context) => SendMailBox(),
        '/receive_page' : (context) => ReceiveMailBox()
      },
      // home: const Home(),
    );
  }
}


