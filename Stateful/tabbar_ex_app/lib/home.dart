
import 'package:flutter/material.dart';
import 'package:tabbar_ex_app/view/first_page.dart';
import 'package:tabbar_ex_app/view/second_page.dart';



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
    // TODO: implement initState
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
        ],
      ),
      bottomNavigationBar: Container(
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.red,
            indicatorWeight: 5,
            labelColor: Colors.red,
            dividerColor: Colors.blue,
            dividerHeight: 3,
            unselectedLabelColor: Colors.grey[500],
          
            tabs: [
              Tab(
                
                icon: Icon(Icons.looks_one),
                child: Text('피카츄 네비 1', style: TextStyle(
                  color: Colors.grey[800]
                )),
              ),
              Tab(
                icon: Icon(Icons.looks_two),
                 child: Text('피카츄 네비 2', style: TextStyle(
                  color: Colors.grey[800]
                )),
              )
            ]
          ),


      ),
    );
  }
}