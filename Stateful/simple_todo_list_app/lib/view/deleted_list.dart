import 'package:flutter/material.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class DeletedList extends StatefulWidget {
  const DeletedList({super.key});

  @override
  State<DeletedList> createState() => _DeletedListState();
}

class _DeletedListState extends State<DeletedList> {
  // Property
  late DatabaseHandle db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('deleted list')
      ),
      body: FutureBuilder(
        future: db.getTodoList(null, TableName.todolist_deleted,0), 
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data != null? snapshot.data!.length:0,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 400,
                height: 150,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Text('id: ${snapshot.data![index].id}'),
                      Text('title: ${snapshot.data![index].title}'),
                      Text('startDate: ${snapshot.data![index].startDate!.toString().substring(0,16)}'),
                    ],
                  )
                ),
              );
            }); 
        },),
    );
  }
}