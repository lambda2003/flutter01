import 'package:chart_barchart_app/util/logInController.dart';
import 'package:chart_barchart_app/view/bar.dart';
import 'package:chart_barchart_app/view/candle.dart';
import 'package:chart_barchart_app/view/line.dart';
import 'package:chart_barchart_app/view/multi_lines.dart';
import 'package:chart_barchart_app/view/scatter.dart';
import 'package:chart_barchart_app/view/tabHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(LoginController());
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
        GetPage(name: '/', page: () => TabHome()),
        GetPage(name: '/bar', page: () => Bar()),
        GetPage(name: '/line', page: () => Line()),
      ],
    );
  }
}
