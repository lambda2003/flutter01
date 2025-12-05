import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/util/back_loop.dart';
import 'package:simple_todo_list_app/view/home.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  backLoop();
  initializeDateFormatting().then((_) => runApp(MyApp()));

}


// void main() {
//   runApp(const MyApp());
// }



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
    );
  }
}
