import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var args = Get.arguments ?? null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (args == null) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${args['imagePath']}',),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "images/${args['imagePath']}",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                '${args['imagePath']}',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
