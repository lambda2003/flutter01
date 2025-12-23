import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_todolist_app/model/todolist.dart';
import 'package:image_todolist_app/view/todolist/insert_view.dart';
import 'package:image_todolist_app/view/todolist/update_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJSONData();
  }

  Future<void> getJSONData() async {
    var url = Uri.parse('http://172.16.250.187:8000/todolist');
    var response = await http.get(url);
    var jsonData = json.decode(utf8.decode(response.bodyBytes));
    // List<Student> result = jsonData["results"].map((d)=>Student.fromJson(d));
    // data.addAll(
    //   result
    // );

    data = jsonData["data"].map((d) => Todolist.fromJson(d)).toList();
    print(data);
  
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD APP'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => InsertTodolistView())!.then((d) {
                getJSONData();
              });
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(data[index].seq),
                    startActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) =>
                              Get.to(
                                () => UpdateTodolistView(),
                                arguments: data[index],
                              )!.then((d) {
                                if (d == true) getJSONData();
                              }),

                          backgroundColor: Colors.green,
                          icon: Icons.update,
                          label: 'update',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) =>deleteTodolist(data[index].seq),

                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'delete',
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "images/${data[index].image}",
                              width: 50,
                            ),
                            // _buildRow('seq: ', data[index].seq.toString()),
                            _buildRow('contents: ', data[index].contents),
                            // _buildRow('image: ', data[index].image),
                            _buildRow('date: ', data[index].insertdate),
                          ],
                        ),
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

  // -- Functions
  Future<void> deleteTodolist(int seq) async {
     final todolist = Todolist(
        seq: seq,
        contents: '',
        image: '',
        insertdate: DateTime.now().toString()

    );
    final url = Uri.parse('http://172.16.250.187:8000/todolist/delete');
    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todolist.toJson()), // body is data (-d)
      );
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData['code'] == 200) {

        data = jsonData["data"].map((d) => Todolist.fromJson(d)).toList();
        getJSONData();  
        // setState(() {});
        Get.snackbar("성공", "데이터를 삭제 했습니다.");
      }
  }

  // ---- Widgets
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
