import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_into_app/view/home.dart';
import 'package:getx_into_app/view/third.dart';


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
      home: const Home(),
      getPages: [
        GetPage(
          name: '/third',
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds:500),
        page:() => Third(),),

      ],
    );
  }
}
