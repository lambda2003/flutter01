import 'package:flutter/material.dart';
import 'package:listview_todo_app/model/todo_list.dart';
import 'package:listview_todo_app/util/message.dart';

class TableList extends StatefulWidget {
  const TableList({super.key});

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  // Property
  late List<TodoList> _todoList;
  late ItemRepository<TodoList> repository;
  @override
  void initState() {
    super.initState();
    repository = ItemRepository<TodoList>();
    _todoList = [];
    addData();
  }

  addData() async {
    // [{}]
    for(var d in ItemRepository.items){
      _todoList.add(d);
      
    }
    // _todoList.add();
  
    // _todoList.add(TodoList(imagePath: 'images/clock.png', workList: '철수와 약속'));
  
    // _todoList.add(
    //   TodoList.fromJson({
    //     'imagePath': 'images/pencil.png',
    //     'workList': '스터디 준비하기',
    //   }),
    // );

   
  }
  // getDataFromWeb() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   _todoList.add(TodoList(imagePath: 'images/cart.png', workList: '책구매'));

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //
              // 중요부분. 
              Navigator.of(
                context,
              ).pushNamed('/insert').then((value) => rebuildData());
              //
              //
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(_todoList[index]),
            onDismissed: (direction) {
              _todoList.remove(_todoList[index]);
              print('==before${ItemRepository.items.length}');

              ItemRepository.items.remove(ItemRepository.items[index]);
              print('==after${ItemRepository.items.length}');

              setState(() {});
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.delete_forever,size:50)
            ),
            child: GestureDetector(
              onTap: () {
                // Message.workList = _todoList[index].workList;

                Navigator.of(context).pushNamed(
                  '/detail',
                  arguments: {
                    'id': index,
                    // 'imagePath':  _todoList[index].imagePath,
                    // 'workList' : _todoList[index].workList,
                  },
                );
              },
              child: Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.asset(_todoList[index].imagePath, width: 40),
                      Text(_todoList[index].workList),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  rebuildData() {
    _todoList.add(
      ItemRepository.items[ItemRepository.items.length - 1],
      // TodoList(imagePath: 'images/pencil.png', workList: '스터디 준비하기'),
    );
    setState(() {});
  }
}
