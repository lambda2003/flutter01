import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:must_eat_place_app/view/check_location.dart';
import 'package:must_eat_place_app/view/insert_data.dart';
import 'package:must_eat_place_app/view/update_data.dart';
import 'package:must_eat_place_app/vm/database_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHandler db = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맛집 리스트'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => InsertData())!.then((v) => reload()),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: db.getData(null),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data != null
                        ? snapshot.data!.length
                        : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.to(
                          CheckLocation(),
                          arguments: snapshot.data![index],
                        ),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: BehindMotion(),
                            children: [
                              SlidableAction(
                                padding: EdgeInsets.fromLTRB(10, 0,0,0),
                                alignment: Alignment.centerLeft,
                                onPressed: (v) => Get.to(
                                  UpdateData(),
                                  arguments: snapshot.data![index],
                                )!.then((value) => reload()),
                                icon: Icons.edit,
                                backgroundColor: Colors.green,
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            children: [
                              SlidableAction(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                alignment: Alignment.centerRight,
                                onPressed: (v) =>
                                    deleteAction(snapshot.data![index].seq!),
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              ),
                            ],
                          ),
                          child: Card(
                            child: Row(
                              spacing: 10,
                              children: [
                                snapshot.data![index].image != null
                                    ? Image.memory(
                                        snapshot.data![index].image!,
                                        width: 100,
                                      )
                                    : Text('empty'),
                                Column(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'name : ${snapshot.data![index].name}',
                                    ),
                                    Text(
                                      'phone : ${snapshot.data![index].phone}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Text('No data'));
          },
        ),
      ),
    );
  }

  // == Functions
  reload() {
    setState(() {});
  }

  deleteAction(int seq) async {
    int result = await db.deleteData(seq);
    setState(() {});
  }
}
