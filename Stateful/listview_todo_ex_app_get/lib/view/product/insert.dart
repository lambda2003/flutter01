import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listview_todo_ex_app_get/model/TodoList.dart';
import 'package:listview_todo_ex_app_get/util/ItemRepository.dart';

class ProductInsert extends StatefulWidget {
  const ProductInsert({super.key});

  @override
  State<ProductInsert> createState() => _ProductInsertState();
}

class _ProductInsertState extends State<ProductInsert> {
  // Property
  late TextEditingController _tc1;
  // ItemRepository<TodoList> repository = ItemRepository();

  bool _isBuy = true;
  bool _isAppoint = false;
  bool _isStudy = false;
  String _image = 'images/cart.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tc1 = TextEditingController();
  }

  @override
  void dispose() {
    _tc1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 25, 8, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/cart.png'),
                        radius: 25,
                      ),
                      Text('구매'),
                      Switch(
                        value: _isBuy,
                        onChanged: (value) => choose(value, 'buy'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/clock.png'),
                        radius: 25,
                      ),
                      Text('약속'),
                      Switch(
                        value: _isAppoint,
                        onChanged: (value) => choose(value, 'appoint'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/pencil.png'),
                        radius: 25,
                      ),
                      Text('공부'),
                      Switch(
                        value: _isStudy,
                        onChanged: (value) => choose(value, 'study'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
              child: Column(
                children: [
                  TextField(
                    controller: _tc1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'todo 리스트에 추가할 내용을 넣어주세요.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.orange,
                        // foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      onPressed: () => add(),
                      child: Text('추가'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  add() {
    if (!_tc1.text.replaceAll(' ', '').isEmpty &&
        (_isBuy || _isAppoint || _isStudy)) {
      String title = _tc1.text.trim();
      ItemRepository.items.add(
        TodoList.fromJson({'imagePath': _image, 'title': title}),
      );
      Get.back(
        result: [
          true,
          TodoList.fromJson({'imagePath': _image, 'title': title}),
        ],
      );
    } else {
      // Get.back(result: [false]);
      Get.snackbar(
        'Warning',
        'TextField is empty.',
        backgroundColor: Color.fromARGB(50, 255, 165, 0),
        duration: Duration(milliseconds: 1500),
      );
    }
  }

  choose(bool value, String n) {
    if (n == 'study') {
      if (!_isBuy && !_isAppoint && value) {
        _image = 'images/pencil.png';
        _isStudy = true;
      } else {
        _isStudy = false;
      }
    } else if (n == 'appoint') {
      if (!_isBuy && value && !_isStudy) {
        _image = 'images/clock.png';
        _isAppoint = true;
      } else {
        _isAppoint = false;
      }
    } else {
      if (value && !_isAppoint && !_isStudy) {
        _image = 'images/cart.png';
        _isBuy = true;
      } else {
        _isBuy = false;
      }
    }
    setState(() {});
  }
}
