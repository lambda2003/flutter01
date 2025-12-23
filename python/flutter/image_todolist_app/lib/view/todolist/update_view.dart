
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_todolist_app/model/todolist.dart';

class UpdateTodolistView extends StatefulWidget {
  const UpdateTodolistView({super.key});

  @override
  State<UpdateTodolistView> createState() => _UpdateTodolistViewState();
}

class _UpdateTodolistViewState extends State<UpdateTodolistView> {

  Todolist? args = Get.arguments;

  TextEditingController contentsController = TextEditingController();
  List<String> imageNames = ['cart.png','clock.png','pencil.png'];
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
    if(args == null){
      Get.back();
    }
    selectedItem = imageNames.indexOf(args!.image);
    contentsController.text = args!.contents;
  }

  @override
  void dispose() {

    contentsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('INSERT')),
      body: Center(
        child: Column(
          children: [
            
            Row(
              children: [
                Image.asset("images/${imageNames[selectedItem]}"),
                SizedBox(
                  width: 300,
                  height: 250,
                  child: CupertinoPicker(
                    itemExtent: 50, 
                    scrollController: FixedExtentScrollController(initialItem: selectedItem),
                    onSelectedItemChanged: (value){
                      selectedItem = value;
                      setState(() {});
                    }, 
                    children: List.generate(
                      imageNames.length, 
                      (index) => SizedBox(
                        width: 300,
                        height: 250,
                        child: Image.asset('images/${imageNames[index]}')
                      ),
                    ),
                  ),
                ),
              ],
            ),


            _buildTextField(contentsController, '내용'),
           


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: ()=>insertTodolist(),
                child: Text('변경'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions

  Future<void> insertTodolist() async {
    try {
      final todolist = Todolist(
        seq: args!.seq,
        contents: contentsController.text.trim(),
        image: imageNames[selectedItem],
        insertdate: DateTime.now().toString()

      );
      
      final url = Uri.parse('http://172.16.250.187:8000/todolist/update');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todolist.toJson()), // body is data (-d)
      );
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      print(jsonData['code']);
      if (jsonData['code'] == 200) {
        // Success
        Get.defaultDialog(
          barrierDismissible: false,
          title: '성공적으로 업데이트 됬습니다.',
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back(result: true);
              },
              child: Text('확인'),
            ),
          ],
        );
      } else {
        // Error
        Get.snackbar("실패", "에러가 발생했습니다.");
      }
    } catch (err) {
      Get.snackbar("시스템에러", "에러가 발생했습니다.");
    }
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.text,
    );
  }
}
