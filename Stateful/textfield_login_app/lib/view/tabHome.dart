import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_login_app/model/animal_list.dart';
import 'package:textfield_login_app/utils/Generic.dart';
import 'package:textfield_login_app/view/tab/first_page.dart';
import 'package:textfield_login_app/view/tab/second_page.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with SingleTickerProviderStateMixin {
  // Property

  late TabController controller;
  late List<Animal> animalList;
    // Property
  Map<String,dynamic> args = Get.arguments ?? {'isSuccess':false};

  @override
  void initState() {
    if(args['isSuccess'] == false){
      MyGeneric.isLogin = false;
      Get.back();
    }
    super.initState();
    controller = TabController(length: 2, vsync: this);
    animalList = [];
    animalList.add(
      Animal(
        animalName: '벌',
        imagePath: 'images/bee.png',
        flyExist: true,
        kind: '곤충',
      ),
    );
    animalList.add(
      Animal(
        animalName: '고양이',
        imagePath: 'images/cat.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '소',
        imagePath: 'images/cow.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '강아지',
        imagePath: 'images/dog.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '여우',
        imagePath: 'images/fox.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '원숭이',
        imagePath: 'images/monkey.png',
        flyExist: false,
        kind: '영장류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '돼지',
        imagePath: 'images/pig.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
    animalList.add(
      Animal(
        animalName: '늑대',
        imagePath: 'images/wolf.png',
        flyExist: false,
        kind: '포유류',
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       print('==== TabHome Rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('${args['id']}님 환영합니다.'),
        leading: IconButton(onPressed: () {
          Get.back(
            result: {'isSuccess':args["isSuccess"]},
          );
        }, icon: Icon(Icons.arrow_back)),
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.red,
          tabs: [
            Tab(icon: Icon(Icons.looks_one), text: 'Table'),
            Tab(icon: Icon(Icons.looks_two), text: 'Insert'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [FirstPage(list: animalList), SecondPage(list: animalList)],
      ),
    );
  }
}
