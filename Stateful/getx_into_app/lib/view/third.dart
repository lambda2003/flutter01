import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
    // Property
  var value = Get.arguments ?? {'id':'-1','title':'empty'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(),
      body: Text('Third - ${value.toString()}'),
    );
  }
}