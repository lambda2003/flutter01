import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Property
  var args =  Get.arguments ?? null;
  late String heroName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(args == null){ Get.back();}
    heroName = args!=null? args['data']:'';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인물보기'),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(heroName),
        ],
      )),
      // body: GridView.builder(
      //   gridDelegate: gridDelegate, 
      //   itemBuilder: itemBuilder
      // )
    );
  }
}