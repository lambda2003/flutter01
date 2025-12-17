
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  // Property
  var args = Get.arguments;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = args[0]['title'];
  }


  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit')
      ),
      body: Center(
        child: Column(children: [
          Image.network(args[0]['image']),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: '타이틀'
            ),
            onSubmitted: (value) async {
              Get.back(result: {"title":titleController.text.trim(),"index":args[1]});
            },
          ),
          
        ],)
      )
    );
  }
}