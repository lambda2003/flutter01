import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listview_insert_app/model/animal_list.dart';
import 'package:listview_insert_app/view/first_page.dart';
import 'package:listview_insert_app/view/second_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Property

  late TabController controller;
  late List<Animal> animalList;

  @override
  void initState() {
    // TODO: implement initState
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
       print('==== Home Rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Test'),
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
