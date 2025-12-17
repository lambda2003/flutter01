import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  var args = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args[1]),
      ),
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
            
          ),
          imageProvider: NetworkImage(args[0]),
          
        )
      ),
    );
  }
}