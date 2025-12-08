import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/common_functions.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
// import 'package:simple_todo_list_app/view/calendar_view.dart';
// import 'package:simple_todo_list_app/view/deleted_list.dart';
// import 'package:simple_todo_list_app/view/home_timer.dart';
// import 'package:simple_todo_list_app/view/insert_todolist.dart';
import 'package:simple_todo_list_app/view/helper/today_report_view.dart';
// import 'package:simple_todo_list_app/view/today_report_view.dart';
// import 'package:simple_todo_list_app/view/update_todolist.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class Home extends StatefulWidget {
  final DatabaseHandle db;
  Map<String, dynamic>? kwd;
  final Function() onReload;
  Home({super.key, required this.db, required this.kwd, required this.onReload});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  late TextEditingController searchController;
  late DateTime? startDate;
  int startNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchController = TextEditingController();
    startDate = null;
    // kwd = {
    //   "today": {"n": true},
    // };

    // // 초기 static 값을 셋팅하기 위해 필요.
    // reload();
  }

  @override
  void dispose() {
    searchController.dispose();
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 5,
                children: [
                  SizedBox(
                    width: screenSize.width / 1.5,
                    height: 40,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: '키워드를 넣어주세요.',
                        labelStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (searchController.text.trim().isEmpty) {
                        widget.kwd = null;
                      } else {
                        widget.kwd = {'name': searchController.text.trim()};
                      }
                      setState(() {});
                    },
                    visualDensity: VisualDensity.comfortable,

                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),

                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.kwd = null;
                      setState(() {});
                    },
                    visualDensity: VisualDensity.comfortable,
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    icon: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),

            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            //     child: Text(
            //       kwd != null
            //           ? '선택: ${TodayReport.titleMap[kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1)]}'
            //           : '선택: 전체보기',
            //     ),
            //   ),
            // ),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 400,
              height: 50,
              child: Row(
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      widget.kwd != null
                          ? '${TodayReport.titleMap[widget.kwd!.keys.toString().substring(1, widget.kwd!.keys.toString().length - 1)]}'
                          : '전체보기',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(alignment: Alignment.centerRight, child: TodayReportView()),
                ],
              ),
            ),

            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: widget.db.getTodoList(widget.kwd, TableName.todolist, startNum), //db!.getTodoList(null, TableName.todolist,startNum),
                builder: (context, snapshot) {
                  return
                  // snapshot.hasData ?
                  snapshot.data == null || snapshot.data!.length == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No Data'),
                              IconButton(
                                onPressed: () {
                                  widget.kwd = null;
                                  setState(() {});
                                },

                                icon: Icon(Icons.refresh_rounded),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) => deleteAction(snapshot.data![index].id!),
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete_outline,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () => Get.toNamed('/update', arguments: snapshot.data![index])!.then((data) => widget.onReload()),
                                //Get.to(UpdateTodolist(), arguments: snapshot.data![index])!.then((data) => reload()),
                                // actionDialog('update', snapshot.data![index]),
                                child: SizedBox(
                                  width: screenSize.width - 8,

                                  child: Card(
                                    color: snapshot.data![index].isDeleted == 1 ? Colors.grey[300] : Colors.grey[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        spacing: 10,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.calendar_month, size: 35),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data![index].title}',
                                                style: TextStyle(color: snapshot.data![index].isDeleted == 1 ? Colors.grey[600] : Colors.black),
                                              ),
                                              Text(
                                                'Date : ${snapshot.data![index].startDate != null ? snapshot.data![index].startDate!.toString().substring(0, 16) : ''}',
                                                style: TextStyle(color: snapshot.data![index].isDeleted == 1 ? Colors.grey[600] : Colors.black),
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    '중요도 :${snapshot.data![index].importance}',
                                                    style: TextStyle(color: snapshot.data![index].isDeleted == 1 ? Colors.grey[600] : Colors.black),
                                                  ),

                                                  snapshot.data![index].importance! >= 6 ? Icon(Icons.priority_high, color: Colors.red) : Text(''),
                                                ],
                                              ),
                                            ],
                                          ),

                                          Container(
                                            width: screenSize.width / 3,
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              children: [
                                                snapshot.data![index].isAlarm == 1
                                                    ? Icon(Icons.lightbulb, color: Colors.amber)
                                                    : Icon(Icons.lightbulb, color: Colors.grey[500]),

                                                // kwd!=null && kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1) == 'isAlarm' ?
                                                snapshot.data![index].isDeleted == 0
                                                    ? ElevatedButton(
                                                        style: ElevatedButton.styleFrom(shape: CircleBorder(eccentricity: 0.3)),
                                                        onPressed: () => toggleAlarmAction(snapshot.data![index]),
                                                        child: Text(
                                                          snapshot.data![index].isAlarm == 1 ? 'ON' : 'OFF',
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                      )
                                                    : Text('알람', style: TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                          ),
                                          // Switch(

                                          //   value: snapshot.data![index].isAlarm==1?true:false, onChanged: null)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                  // : Center(child: const CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  deleteAction(int id) async {
    final int result = await widget.db.deleteTodoList(id);
    widget.onReload();
    CommonFunctions.showMessage(result, '삭제');
    // Get.to(DeletedList())!.then((value) => setState(() {}));
  }

  toggleAlarmAction(TodoList todolist) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (todolist.isAlarm == 0 && todolist.startDate!.millisecondsSinceEpoch < now) {
      CommonFunctions.showMessage(-110, '알람변경');
      return;
    }
    int result = await widget.db.toggleAlarm(todolist);
    if (result != 0) widget.onReload();

    CommonFunctions.showMessage(result, '알람변경');
  }
}
