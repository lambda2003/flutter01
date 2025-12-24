import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_image_app/component/global_widget.dart';
import 'package:mysql_image_app/view/insert_address.dart';
import 'package:mysql_image_app/view/update_address.dart';

class QueryAddress extends StatefulWidget {
  const QueryAddress({super.key});

  @override
  State<QueryAddress> createState() => _QueryAddressState();
}

class _QueryAddressState extends State<QueryAddress> {
  // Property

  List data = [];

  @override
  void initState() {
    super.initState();
    getJSONData(-1);
  }

  Future<void> getJSONData(int index) async {
    if(index == -1){
      data.clear();
      final url = Uri.parse('http://172.16.250.187:8000/select/0');
      final response = await http.get(url);
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
     
      data = jsonData['data'];
    }else{

      final url = Uri.parse('http://172.16.250.187:8000/select/${data[index]['seq']}');
      final response = await http.get(url);
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
     
      data[index]['name'] =  jsonData['data'][0]['name'];
      data[index]['phone'] =  jsonData['data'][0]['phone'];
      data[index]['address'] =  jsonData['data'][0]['address'];
      data[index]['relation'] =  jsonData['data'][0]['relation'];

    }

    /*
    List result = jsonData['data];
    data.addAll(result);
    */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Mysql'),
        actions: [
          IconButton(
            onPressed: ()=>Get.to(()=>InsertAddress())!.then((d){
              getJSONData(-1);
            }),
          
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
                                  onPressed: (context)=>Get.to(()=>UpdateAddress(),arguments: data[index])!.then((d){
                                    if(d!=null && d){
                                      getJSONData(index);
                           
                                    }
                                  }),
                                  icon: Icons.edit_outlined,
                                  backgroundColor: Colors.green,
                                )
                              ]
                          ),
                          

                          child: Card(
                            child: Row(
                              spacing: 10,
                              children: [
                                Image.network('http://172.16.250.187:8000/view/${data[index]['seq']}?t=${DateTime.now().microsecondsSinceEpoch}',width:100),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildRow(data[index]['name'], '이름'),
                                    _buildRow(data[index]['phone'], '전번'),
                                  ],
                                ),
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
  Future<void> deleteItem(int seq,int index) async{
    final url = Uri.parse('http://172.16.250.187:8000/delete/${seq}');
    final response = await http.delete(
      url
      );
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    print("${jsonData['code']} ====== ");
    if(jsonData['code'] == 200){
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
