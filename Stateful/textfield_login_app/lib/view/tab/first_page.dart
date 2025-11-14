import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_login_app/model/animal_list.dart';

class FirstPage extends StatefulWidget {
  //
  final List<Animal> list;
  FirstPage({super.key, required this.list});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {



  @override
  Widget build(BuildContext context) {
      print('==== FirstPage');
      print(widget.list.length);
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(widget.list[index]),
            onDismissed: (value) {
              widget.list.removeAt(index);
              setState(() {});
            },
            
            background: Container(
              width:100,
              height:100,
              color:Colors.red[500],
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete_forever)
              ),
            ),
            child: GestureDetector(
              onTap: () => _showDialog(index),

              child: Card(
                child: Row(
                  spacing: 10,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          widget.list[index].imagePath,
                        ),
                      ),
                    ),
                    // Image.asset(widget.list[index].imagePath,width:100),
                    Text(widget.list[index].animalName),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // == Functions
  _showDialog(index) {
    Get.defaultDialog(
      title: widget.list[index].animalName,
      middleText:
          '이 동물은 "${widget.list[index].kind}" 입니다.\n'
          '${widget.list[index].flyExist ? "날 수 있습니다" : "날 수 없습니다."}',
      barrierDismissible: false,
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('종료')),
        // TextButton(onPressed: () {
        //   Get.back(
        //     result: {"isRemove":true},
        //   );
        // }, child: Text('삭제'))
      ],
    );
  }
}
