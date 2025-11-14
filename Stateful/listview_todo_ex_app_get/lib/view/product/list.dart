import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listview_todo_ex_app_get/model/TodoList.dart';
import 'package:listview_todo_ex_app_get/util/ItemRepository.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Propery

  late List<TodoList> _items;
  bool _isReload = false;
  @override
  void initState() {
    super.initState();
    _items = [];

    // Before displaying page, set DB.
    ItemRepository.items.add(
      TodoList.fromJson({'imagePath': 'images/cart.png', 'title': '책구매'}),
    );
    ItemRepository.items.add(
      TodoList.fromJson({'imagePath': 'images/clock.png', 'title': '철수와 약속'}),
    );
    ItemRepository.items.add(
      TodoList.fromJson({
        'imagePath': 'images/pencil.png',
        'title': '스터디 준비하기',
      }),
    );

    _items.add(ItemRepository.items[0]);
    _items.add(ItemRepository.items[1]);
    _items.add(ItemRepository.items[2]);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              var returnValue = await Get.toNamed('/insert');
              if(returnValue != null){
                updateData(returnValue);
              }
              // Navigator.of(
              //   context,
              // ).pushNamed('/insert').then((value) => updateData());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_items[index]),
            onDismissed: (direction) => removeData(index),
            background: Container(
              alignment: AlignmentGeometry.centerRight,
              color: Colors.orange,
              child: Icon(Icons.delete_forever),
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/detail',arguments: [true,_items[index],index] );
                // Navigator.of(
                //   context,
                // ).pushNamed('/detail', arguments: {'id': index});
              },
              child: Card(
                child: Row(
                  children: [
                    Image.asset(_items[index].imagePath),
                    Text(_items[index].title),
                    Text(
                      '====${_items.length} ==== ${ItemRepository.items.length}',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // === Functions


  // Insert handling
  // After inserting, update the page. 
  updateData(returnValue) {

    print('updated=======');
    if (returnValue[0] == true) {
      _items.add(returnValue[1]);
      setState(() {});
    }
  }

  refreshPage() async {
   
  
      _items = [];
      for(TodoList d in ItemRepository.items){
        _items.add(d);
      }
       _isReload = false;
       await Future.delayed(Duration(milliseconds: 1000));
      setState(() {});
     
   
  }

  // Delete Handling
  removeData(int index) {
    print('deleted =======');
    _items.removeAt(index);

    // DB: delete
    ItemRepository.items.removeAt(index);
    setState(() {});
  }
}
