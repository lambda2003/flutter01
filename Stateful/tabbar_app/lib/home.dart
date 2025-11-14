import 'package:flutter/material.dart';
import 'package:tabbar_app/view/first_page.dart';
import 'package:tabbar_app/view/second_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Property
  late TabController controller;
 
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('피카츄 이미지 텝바'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: TabBarView(
        controller: controller,
        children: [
          FirstPage(),
          SecondPage(),
        ]
      ),

      bottomNavigationBar: Container(
        color: Colors.grey[300],
        height: 80,
        child: TabBar(
          controller: controller,
          labelColor: Colors.red,
          indicatorColor: Colors.grey[400],
          indicatorWeight: 5,
          tabs: [
            Tab(
              
              icon: Icon(Icons.image),
              // text: "one",
              child: Text('피카츄리스트',style:TextStyle(color:Colors.grey[700])),
            ),
            Tab(
              icon: Icon(Icons.looks_two),
              child: Text('피카츄삼각',style:TextStyle(color:Colors.grey[700])),
            ),
          ],
        ),
      ),
    );
  }
}