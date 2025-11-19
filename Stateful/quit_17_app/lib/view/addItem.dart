import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quit_17_app/model/item.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  late TextEditingController _controller;
  // Null Handling
  var args = Get.arguments ?? {'list':[Item(name:'쇼핑',imagePath:'cart.png')]};

  // late Item item;
  late String _imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _imagePath = args['list'][0].imagePath;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add View'),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset('images/${_imagePath}'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.deepPurple[100],
                      width: 300,
                      height: 150,
                      child: CupertinoPicker(
                        itemExtent: 80,
                        scrollController: FixedExtentScrollController(
                          initialItem: 0,
                        ),
                        onSelectedItemChanged: (index) {
                          //
                          _imagePath = args["list"][index].imagePath;
                          setState(() {});
                        },
                        children: List.generate(
                          args['list'].length,
                          (index) => SizedBox(
                            child: Image.asset(
                              'images/${args['list'][index].imagePath}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '목적을 입력하세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[100],
              ),
              onPressed: () => confirmForm(),
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  confirmForm() {
    if (!_controller.text.trim().isEmpty) {
      // Do something
      Item item = Item(name: _controller.text.trim(), imagePath: _imagePath);
      Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: SizedBox(height: 100, child: Text(
          '아이템을 추가 하시겠습니까? \n'
          '목적: ${item.name}\n'
          '이미지: ${item.imagePath}'
        )),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(result: item);
            },
            child: Text('네'),
            
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('아니오'),
            
          ),
        ],
      );
    } else {
      // Error alert messge
      Get.snackbar('Info', '목적을 넣어 주세요.');
    }
  }
}
