import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sqlite_image_app/model/address.dart';
import 'package:sqlite_image_app/view/insert_address.dart';
import 'package:sqlite_image_app/view/update_address.dart';
import 'package:sqlite_image_app/vm/database_handle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // property
  late DatabaseHandle db;
  late TextEditingController searchController;
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenWidth%100*100;
    return Scaffold(
      appBar: AppBar(
        title: Text('주소검색'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertAddress())!.then((value) => reload()),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),

      /*
  SizedBox(
              height: 100,
              child: Row(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: '검색할 이름을 넣어주세요.'
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()=>searchAction(), child: Text('검색'))
                ],
              ),
            ),
      */
      body: Center(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(labelText: '검색할 이름을 넣어주세요.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(onPressed: () => searchAction(true), child: Text('검색')),
                   ElevatedButton(onPressed: () => searchAction(false), child: Text('RESET')),
                ],
              ),
            ),
           
            SizedBox(
              width: 400,
              height: 500,
              child: FutureBuilder(
                future: isSearch? db.getAddress(searchController.text.trim()) : db.getAddress(null),
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.to(
                                UpdateAddress(),
                                arguments: [snapshot.data![index]],
                              )!.then((value) => reload()),
                              child: SizedBox(
                                width: 400,
                                height: 120,
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (value) => deleteAction(
                                          snapshot.data![index].id!,
                                        ),
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      spacing: 10,
                                      children: [
                                        Image.memory(
                                          snapshot.data![index].image,
                                          width: 100,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '이름: ${snapshot.data![index].name}',
                                            ),
                                            Text(
                                              '전화: ${snapshot.data![index].phone}',
                                            ),
                                            Text(
                                              '주소: ${snapshot.data![index].address}',
                                            ),
                                            Text(
                                              '관계: ${snapshot.data![index].relation}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Text('데이터가 없습니다.');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Function
  reload() {
    setState(() {});
  }

  searchAction(bool b) async {
    //List<Address> ll = await db.getAddress(searchController.text.trim());
    isSearch = b;
    if(!b) searchController.text='';
    //print('====${ll.toString()}');
    setState(() {});
  }

  Future deleteAction(int id) async {
    final int result = await db.deleteAddress(id);
    if (result != 0) {
      // sucess
      Get.snackbar('알림', '성공적으로 지워졌습니다.', backgroundColor: Colors.green);
      setState(() {});
    } else {
      // fail
      Get.snackbar('에러', '문제가 발생했습니다.', backgroundColor: Colors.red);
    }
  }
}
