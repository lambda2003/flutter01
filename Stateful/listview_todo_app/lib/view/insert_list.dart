import 'package:flutter/material.dart';
import 'package:listview_todo_app/model/todo_list.dart';
import 'package:listview_todo_app/util/message.dart';

class InsertList extends StatefulWidget {
  const InsertList({super.key});

  @override
  State<InsertList> createState() => _InsertListState();
}

class _InsertListState extends State<InsertList> {
  
  // Property
  late TextEditingController tc_imagePath;
  late TextEditingController tc_workList;
  late ItemRepository<TodoList> repository;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tc_imagePath = TextEditingController();
    tc_workList = TextEditingController();
    repository = ItemRepository<TodoList>();
  }
   
  @override
  void dispose() {
    tc_imagePath.dispose();
    tc_workList.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: tc_imagePath,
              keyboardType: TextInputType.text,

            ),
            TextField(
              controller: tc_workList,
              keyboardType: TextInputType.text,

            ),
            ElevatedButton(onPressed: ()=>add(), child: Text('추가')),
          ],
        )
      ),
    );
  }
  // === Functions

  add(){
    if(!tc_imagePath.text.isEmpty && !tc_workList.text.isEmpty) {
      repository.addItems(TodoList(imagePath:tc_imagePath.text, workList: tc_workList.text ));
      Navigator.of(context).pop();
    }
  }
}