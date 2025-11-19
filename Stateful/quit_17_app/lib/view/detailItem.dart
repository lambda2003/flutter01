import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({super.key});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
    var args = Get.arguments ?? null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('images/${args["item"].imagePath}'),
        Text(args["item"].name),

      ],),)
    );
  }
}