
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property
  late List<int> todoList;

  @override
  void initState() {
    super.initState();
    todoList = [];
    addData();
  }

  addData(){
    // todoList.add('James');
    // todoList.add('Cathy');
    // todoList.add('Martin');
    // todoList.add('유비');
    // todoList.add('관우');
    // todoList.add('장비');
    for(int i=1;i<5;i++){
      todoList.add(i);
    }
  }

  addMore(){
    for(int i=5;i<11;i++){
      todoList.add(i);
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainView'),
        centerTitle: true,
      
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index){
            return SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsetsGeometry.all(5),
                color: index%2 == 0? Colors.green[200] : Colors.green,
              
                child: Center(
                  child: Text(
                    todoList[index].toString(),
                    style: TextStyle(fontSize: index%2 == 0? 20:40),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  
  
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}