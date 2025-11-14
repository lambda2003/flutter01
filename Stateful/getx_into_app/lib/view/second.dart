import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {

  // Property
  var value = Get.arguments ?? '_______';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Second')
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed:() => Get.back(

              ), 
              child: Text('Exit')
            ),
            Text('xxxxx value = ${value.toString()}'),


             ElevatedButton(
              onPressed:() => Get.back(
                result: "GOOD",
              ), 
              child: Text('Exit - Return value(Reply)')
            ),
          ],
        )
      ),
    );
  }
}