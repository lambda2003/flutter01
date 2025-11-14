import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_login_app/model/animal_list.dart';

class SecondPage extends StatefulWidget {
  final List<Animal> list;
  SecondPage({super.key, required this.list});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // Property
  late TextEditingController nameController;
  late int _radioValue;
  late bool flyExist;
  late String _imagePath;
  late String imageName;
  late List<Color> animalColor;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _radioValue = 0;
    flyExist = false;
    _imagePath = '';
    imageName = '';
    animalColor = [
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
    ];
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      print('==== SecondPage');
      print(widget.list.length);
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: '등록할 동물 이름을 입력하세요'),
            keyboardType: TextInputType.text,
            maxLength: 20,
            maxLines: 1,
          ),
          RadioGroup(
            groupValue: _radioValue,
            onChanged: (value) {
              _radioValue = value!;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(value: 0),
                Text('양서류'),
                Radio(value: 1),
                Text('파충류'),
                Radio(value: 2),
                Text('포유류'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('날수 있나요?'),
              Checkbox(
                value: flyExist,
                onChanged: (value) {
                  flyExist = value!;
                  setState(() {});
                },
              ),
            ],
          ),

          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => rebuildBorder(index),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: animalColor[index],
                        width: 2,
                      ),
                    ),
                    child: Image.asset(widget.list[index].imagePath),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _showDialog(),
            child: Text('동물 추가하기'),
          ),
        ],
      ),
    );
  }

  // == Functions
  rebuildBorder(int index) {
    for (int i = 0; i < animalColor.length; i++) {
      animalColor[i] = Colors.yellow;
    }

    animalColor[index] = Colors.red;
    _imagePath = widget.list[index].imagePath;
    // flyExist = widget.list[index].flyExist;
    // String kind = widget.list[index].kind;

    setState(() {});
  }

  _showDialog() async {
    Animal animal = Animal(
      imagePath: _imagePath,
      animalName: nameController.text.trim(),
      kind: getKind(_radioValue),
      flyExist: flyExist,
    );
    await Get.defaultDialog(
      barrierDismissible: false,
      title: '동물추가하기',
      middleText:
          '이 동물은 ${animal.animalName} 입니다.\n'
          '종류는 ${animal.kind}\n'
          '이 동물을 추가 하시겠습니까? ',
      actions: [
        Row(
          children: [
            TextButton(onPressed: () {
              widget.list.add(animal);
              animalColor.add(Colors.yellow);
              setState(() {});
              reset();
              Get.back();
              
            }, child: Text('네')),
            TextButton(onPressed: () => Get.back(), child: Text('아니오')),
          ],
        ),
      ],
    );
  }
  reset(){
    nameController.text = '';
     _radioValue = 0;
    flyExist = false;
    _imagePath = '';
    imageName = '';
    for (int i = 0; i < animalColor.length; i++) {
      animalColor[i] = Colors.yellow;
    }
    setState(() {
      
    });
  }
  String getKind(int value) {
    switch (value) {
      case 0:
        return '양서류';
      case 1:
        return '파충류';
      default:
        return '포유류';
    }
  }
}
