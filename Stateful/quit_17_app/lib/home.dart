import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quit_17_app/model/item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<Item> list;
  late List<Item> defaultList;
  bool _isWorking = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [];
    defaultList = [];
    _addItem();
  }

  _addItem() {
    list.add(Item(name: '쇼핑', imagePath: 'cart.png'));
    list.add(Item(name: '약속', imagePath: 'clock.png'));
    list.add(Item(name: '공부', imagePath: 'pencil.png'));
    
    defaultList.add(Item(name: '쇼핑', imagePath: 'cart.png'));
    defaultList.add(Item(name: '약속', imagePath: 'clock.png'));
    defaultList.add(Item(name: '공부', imagePath: 'pencil.png'));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width~/100 * 100;
    double screenHeight = screenWidth * 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Get.toNamed('/add', arguments: {"list": defaultList});
              if (result != null) {
                list.add(result);
                setState(() {});
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Todo List',style: TextStyle(
              fontSize: 20,
            ),),
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return  Dismissible(
                      key: ValueKey(list[index]),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){
                        list.remove(list[index]);
                        setState(() {});
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete_forever),
                        color: Colors.red[300],
                      ),

                    child: Container(
                      height: 80,
                      child:
                           GestureDetector(
                    onTap: () {
                      if(!_isWorking)
                        Get.toNamed('/detail', arguments: {"item": list[index]});
                    },

                        child: Card(
                          key: ValueKey(list[index]),
                          child: Row(
                            spacing: 10,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  'images/${list[index].imagePath}',
                                ),
                              ),
                              Text(list[index].name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
