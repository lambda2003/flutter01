import 'package:flutter/material.dart';
import 'package:listview_todo_app/model/todo_list.dart';
import 'package:listview_todo_app/util/message.dart';

class DetailList extends StatefulWidget {
  const DetailList({super.key});

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {

  
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args["id"]);
    int id = args["id"]!=null?args["id"]:0;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Row(children: [
                 Image.asset(ItemRepository.items[id].imagePath),
                Text(ItemRepository.items[id].workList),
                
              ],
              )
            ),
            ElevatedButton(onPressed: ()=>remove(id), child: Text('remove'))
          ],
        )
      ),
    );
  }

  // == Functions
  remove(int id){
    
  }
}