import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todolist_mysql_app/component/global_widget.dart';


class ListTodolist extends StatefulWidget {
  const ListTodolist({super.key});

  @override
  State<ListTodolist> createState() => _ListTodolistState();
}

class _ListTodolistState extends State<ListTodolist> {
  // Property
  TextEditingController controller = TextEditingController();
  List data = [];

  @override
  void initState() {
    super.initState();
    getJSONData(-1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getJSONData(int index) async {
    
      data.clear();
      final url = Uri.parse('http://172.16.250.187:8000/list');
      final response = await http.get(url);
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
     
      data = jsonData['data'];
   
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todolist Mysql'),
        actions: [
          IconButton(
            onPressed: ()=>showInsertDialog(),
          
            icon: Icon(Icons.add)
          )
        ],
      
      ),
    
      body: Center(
        child: data.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width - 100,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Slidable(

                          endActionPane: ActionPane(
                              motion: BehindMotion(), 
                              children: [
                                SlidableAction(
                                  onPressed: (context)=>deleteItem(data[index]['seq'],index),
                                  icon: Icons.delete_outline,
                                  backgroundColor: Colors.red,
                                )
                              ]
                          ),
                           startActionPane: ActionPane(
                              motion: BehindMotion(), 
                              children: [
                                SlidableAction(
                                  onPressed: (context){
                                    // update
                                  },
                                  icon: Icons.edit_outlined,
                                  backgroundColor: Colors.green,
                                )
                              ]
                          ),
                          

                          child: Card(
                            child: Row(
                              spacing: 10,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                 
                            
                                    Icon(Icons.calendar_month),
                                    _buildRow(data[index]['title'], '타이틀'),
                                    _buildRow(data[index]['meet_date'], '날짜'),
                              
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }




  // == Functions
  void showInsertDialog(){
    Get.defaultDialog(
      title: "TodoList",
      content: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "추가한 내용"
            ),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: ()=>insertItem(), child: Text('추가하기'))
      ]

    );
  }

  Future<void> insertItem() async {

    final url = Uri.parse('http://172.16.250.187:8000/add');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"}, 
      body:json.encode({
        "seq": 0,
        "title": controller.text.trim(),
        "content": "-",
        "meet_date": DateTime.now().toString()
      })
    );
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    if(jsonData['code'] == 200){
      controller.text = '';
      getJSONData(-1);
      Get.back();
      
    }else{
      print('==-=-=-=- ERROR');
    }
  }

  
  Future<void> deleteItem(int seq,int index) async{
    final url = Uri.parse('http://172.16.250.187:8000/delete');
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"}, 
      body:json.encode({
        "seq": seq,
        "title": "",
        "content": "",
        "meet_date":""
      })
      );
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    print("${jsonData['code']} ====== ");
    if(jsonData['code'][0] == 200){
      data.removeAt(index);
      setState(() {});
    }else{
      GlobalWidget.errorSnackBar("삭제할때 문제가 발생했습니다.");
    }
    
  }

  // -- widget
  Widget _buildRow(data, String s) {
    return Text('${s} : ${data}');
  }
}
