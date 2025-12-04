import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/view/deleted_list.dart';
import 'package:simple_todo_list_app/view/home_timer.dart';
import 'package:simple_todo_list_app/view/insert_todolist.dart';
import 'package:simple_todo_list_app/view/today_report_view.dart';
// import 'package:simple_todo_list_app/view/today_report_view.dart';
import 'package:simple_todo_list_app/view/update_todolist.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  late DatabaseHandle db;
  late TextEditingController searchController;
  late DateTime? startDate;
  late Map<String, dynamic>? kwd;
  int startNum = 0;
  bool isAlarmOn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
    searchController = TextEditingController();
    startDate = null;
    kwd = null;

    // 초기 static 값을 셋팅하기 위해 필요.
    reload();
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

    return Scaffold(
      // backgroundColor: isAlarmOnColor ? Colors.red : Colors.white,
      appBar: AppBar(
        title: Text('TODO LIST'),
        actions: [
          // IconButton(
          //   onPressed: () => Get.to(DeletedList()),
          //   icon: Icon(Icons.delete),
          // ),
          ElevatedButton(
            onPressed: () => {
              //
            },
            child: GestureDetector(
              onTap: () {
                print('111111');
                kwd = {'isAlarm': 1};
                setState(() {});
              },
              child: HomeTimer(isTurnOn: isAlarmOn, db: db),
            ),

            // icon: isAlarmOn
            //     ? Icon(Icons.notifications_active, color: Colors.red[400])
            //     : Icon(Icons.notifications_off),
          ),
          IconButton(
            onPressed: () => Get.to(
              InsertTodolist(),
            )!.then((data) => reload()), //actionDialog('insert', null),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.today, color: Colors.black),
              title: Text('오늘할일 (${TodayReport.count})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {
                  "today": {"n": true},
                };
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.today, color: Colors.black),
              title: Text('전체보기'),
              // subtitle: Text(''),
              onTap: () {
                kwd = null;
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.priority_high_outlined, color: Colors.red),
              title: Text('전체 중요일정 (${TodayReport.totalImportanceCount})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'importance': 5};
                setState(() {});
                Get.back();
              },
            ),

            ListTile(
              leading: Icon(Icons.alarm_on),
              title: Text('전체 알람일정 (${TodayReport.totalAlarmCount})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'isAlarm': 1};
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: isAlarmOn
                  ? Icon(Icons.settings, color: Colors.amber[300])
                  : Icon(Icons.settings, color: Colors.grey[300]),
              title: Text(isAlarmOn ? '알람 끄기' : '알람 켜기'),
              // subtitle: Text(''),
              onTap: () {
                isAlarmOn = !isAlarmOn;
                setState(() {});
                Get.back();
              },
            ),
          ],
        ),
      ),
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
                    height:40,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: '키워드를 넣어주세요.',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (searchController.text.trim().isEmpty) {
                        kwd = null;
                      } else {
                        kwd = {'name': searchController.text.trim()};
                      }
                      setState(() {});
                    },
visualDensity: VisualDensity.comfortable,
     

                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        
                      ),
                      
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      kwd = null;
                      setState(() {});
                    },
                    visualDensity: VisualDensity.comfortable,
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
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
                  Text(
                    kwd != null
                        ? '${TodayReport.titleMap[kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1)]}'
                        : '전체보기',
                    style: TextStyle(fontSize: 20),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TodayReportView(),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: db.getTodoList(
                  kwd,
                  TableName.todolist,
                  startNum,
                ), //db!.getTodoList(null, TableName.todolist,startNum),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data!.length == 0
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No Data'),
                                    IconButton(
                                      onPressed: () {
                                        kwd = null;
                                        setState(() {});
                                      },

                                      icon: Icon(Icons.refresh_rounded),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data != null
                                    ? snapshot.data!.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      motion: BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => deleteAction(
                                            snapshot.data![index].id!,
                                          ),

                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_outline,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Get.to(
                                        UpdateTodolist(),
                                        arguments: snapshot.data![index],
                                      )!.then((data) => reload()),
                                      // actionDialog('update', snapshot.data![index]),
                                      child: SizedBox(
                                        width: screenSize.width - 8,

                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              spacing: 10,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 35,
                                                ),

                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data![index].title}',
                                                    ),
                                                    Text(
                                                      'Date : ${snapshot.data![index].startDate != null ? snapshot.data![index].startDate!.toString().substring(0, 16) : ''}',
                                                    ),

                                                    Row(
                                                      children: [
                                                        Text(
                                                          '중요한 약속 (${snapshot.data![index].importance})',
                                                        ),

                                                        snapshot
                                                                    .data![index]
                                                                    .importance! >=
                                                                6
                                                            ? Icon(
                                                                Icons
                                                                    .priority_high,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : Text(''),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                Container(
                                                  width: screenSize.width / 3,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Column(
                                                    children: [
                                                      snapshot
                                                                  .data![index]
                                                                  .isAlarm ==
                                                              1
                                                          ? Icon(
                                                              Icons.lightbulb,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                          : Icon(
                                                              Icons.lightbulb,
                                                              color: Colors
                                                                  .grey[500],
                                                            ),

                                                      // kwd!=null && kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1) == 'isAlarm' ?
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            toggleAlarmAction(
                                                              snapshot
                                                                  .data![index],
                                                            ),

                                                        child: Text('알람'),
                                                      ),

                                                      // : Text(
                                                      //   '알람',
                                                      //   style: TextStyle(fontSize: 13)
                                                      // ),
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
                              )
                      : Center(child: const CircularProgressIndicator());
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
    final int result = await db.deleteTodoList(id);
    reload();
    showMessage(result, '삭제');
    // Get.to(DeletedList())!.then((value) => setState(() {}));
  }

  toggleAlarmAction(TodoList todolist) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (todolist.isAlarm == 0 &&
        todolist.startDate!.millisecondsSinceEpoch < now) {
      showMessage(-110, '알람변경');
      return;
    }
    int result = await db.toggleAlarm(todolist);
    if (result != 0) reload();
    showMessage(result, '알람변경');
  }

  // 모든 DB 변경이 일어나면 실행시킨다.
  // - 추후 다른 페이지에서도 볼수 있게 Static으로 저장
  reload() async {
    List<int> data = await db.getTodayReport();
    TodayReport.alarmCount = data[0]; // today alarmcount
    TodayReport.importantCount = data[1]; // today importance
    TodayReport.count = data[2]; // today count
    TodayReport.totalImportanceCount = data[3]; // total importance count
    TodayReport.totalAlarmCount = data[4]; // totalAlarmCount
    setState(() {});
  }

  // TODO: GT=> 에러코드에 대한 정의가 필요
  /*
    -110은 toggle에서 validation fail됬을시 에러.
  */
  showMessage(int i, String msg) {
    if (i == 0) {
      Get.snackbar('에러', '$msg에 에러가 발생했습니다.', backgroundColor: Colors.red);
    } else {
      if (i == -110) {
        Get.snackbar(
          '알림',
          '$msg일 불가합니다. 날짜를 변경하세요.',
          backgroundColor: Colors.orange[500],
        );
      } else {
        Get.snackbar('알림', '$msg에 성공했습니다.', backgroundColor: Colors.green[500]);
      }
    }
  }

  // alarmCheck() async {
  //   print('==called');

  //   if (loopCount > 24) {
  //     isAlarmOn = false;
  //     isAlarmOnColor = false;
  //     timer.cancel();
  //     print('타이머 cancelled========');
  //     setState(() {});
  //   }

  //   if (!isWorking && !isAlarmOn) {
  //     isWorking = true;
  //     List<TodoList> data = await db!.getTodoList(
  //       {"isAlarm": 1},
  //       TableName.todolist_alarm,
  //       0,
  //     );
  //     DateTime now = DateTime.now();

  //     for (int i = 0; i < data.length; i++) {
  //       TodoList d = data[i];
  //       // print(now.subtract(Duration(minutes: 30)).toString());
  //       // print(d.startDate!.toString());
  //       // print(now.subtract(Duration(minutes: 30)).millisecond.toString());
  //       // print(d.startDate!.microsecond.toString());
  //       if (d.startDate != null &&
  //           now.subtract(Duration(minutes: 30)).millisecondsSinceEpoch <=
  //               d.startDate!.millisecondsSinceEpoch) {
  //         if (now.millisecondsSinceEpoch <
  //             d.startDate!.millisecondsSinceEpoch) {
  //           print('알람..알람..알람.');
  //           isAlarmOnColor = !isAlarmOnColor;
  //           isAlarmOn = true;
  //         } else {
  //           // 알람을 끈다.
  //           d.isAlarm = 0;
  //           isAlarmOnColor = false;
  //           isAlarmOn = false;
  //           int result = await db!.deleteAalarm(d.id!);
  //           if (result != 100) {
  //             timer.cancel();
  //             Get.snackbar('알림', '타이머 취소됨....');
  //             break;
  //           }
  //         }
  //       }

  //       print('=== hitted == ${loopCount}');
  //     }
  //   }
  //   print('isAlarmon:${isAlarmOn}');
  //   if (isAlarmOn) {
  //     isAlarmOnColor = !isAlarmOnColor;
  //     setState(() {});
  //   }
  //   loopCount++;
  //   isWorking = false;
  // }
  // actionDialog(String isType, TodoList? todolist) async {
  //   if (isType == 'insert') {
  //     titleController.text = '';
  //         startDate = null;
  //   } else {
  //     titleController.text = todolist != null ? todolist.title : '';
  //         startDate =  DateTime.parse(todolist!.startDate!);
  //   }

  //   Get.dialog(
  //     AlertDialog(
  //       title: Text(isType == 'insert' ? 'Todo List 추가' : 'Todo list 변경'),
  //       content: SizedBox(
  //         width: 300,
  //         height: 200,
  //         child: Column(
  //           children: [
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(labelText: "todolist를 입력하세요."),
  //             ),
  //              DropdownButton(
  //             dropdownColor: Theme.of(context).colorScheme.primaryContainer,
  //             iconEnabledColor: Theme.of(context).colorScheme.primary,
  //             value: dropDownValue,
  //             icon: Icon(Icons.arrow_drop_down),

  //             items: List.generate(11, (index) {
  //                   return DropdownMenuItem(
  //                 value: index+1,
  //                 child: Text(
  //                   (index+1).toString(),
  //                   style: TextStyle(
  //                     color: Theme.of(context).colorScheme.onPrimaryContainer,
  //                   ),
  //                 ),

  //               );

  //             },

  //             ),
  //               onChanged: (value) {
  //               dropDownValue = value!;
  //               setState(() { });
  //             },

  //           ),

  //             TextButton(
  //               onPressed: ()=>showCalendar(),
  //               child: Row(children: [
  //                 Text('StartDate:'),
  //                 Icon(Icons.calendar_month),

  //               ],)
  //             ),

  //           ],
  //         ),
  //       ),
  //       actions: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [

  //             TextButton(
  //               onPressed: () async {
  //                 //

  //                 if (isType == 'insert') {
  //                   final tmpTodolist = TodoList(
  //                     title: titleController.text.trim(),
  //                     startDate: startDate == null? DateTime.now().toString(): startDate.toString(),
  //                     importance: dropDownValue,
  //                   );

  //                   int result = await db!.insertTodoList(tmpTodolist,TableName.todolist);
  //                   resultHandle(isType,result);
  //                   // if (result != 0) {
  //                   //   Get.back();
  //                   //   setState(() {
  //                   //     titleController.text = '';
  //                   //   });
  //                   // } else {
  //                   //   resultHandle(isType,result);
  //                   // }
  //                 } else {
  //                   // final tmpTodolist = TodoList(
  //                   //   id: todolist!.id,
  //                   //   title: titleController.text.trim(),
  //                   //   startDate: DateTime.now().toString(),
  //                   // );
  //                   // if(todolist!.title == titleController.text.trim()){
  //                   //   resultHandle(isType,-1);
  //                   // }else{}
  //                     todolist!.title = titleController.text.trim();
  //                     todolist!.startDate = startDate == null? DateTime.now().toString(): startDate.toString();
  //                     int result = await db!.updateTodoList(todolist,TableName.todolist);
  //                     resultHandle(isType,result);
  //                     // if (result != 0) {
  //                     //   Get.back();
  //                     //   setState(() {});
  //                     //   // reload();
  //                     // } else {
  //                     //   // Show snackbar
  //                     //  errorMessageHandle(isType,result);
  //                     // }

  //                 }
  //               },
  //               child: Text('저장'),
  //             ),
  //             TextButton(onPressed: () => Get.back(), child: Text('취소')),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // resultHandle(String isType, int result) {
  //   if (result == 0) {
  //     Get.snackbar(
  //       isType != 'insert' ? '업데이트 하는 동안 에러가 발생했습니다.' : '추가하는 동안 에러가 발생했습니다.',
  //       '다시 시도해 보세요.',
  //     );
  //   } else if (result == -1) {
  //     Get.back();
  //     Get.snackbar(
  //       '알림: ',
  //       isType != 'insert' ? '업데이트 성공(${result}).' : '추가 성공',
  //       backgroundColor: Colors.deepPurple[100],
  //     );
  //   } else {
  //     Get.back();
  //     Get.snackbar(
  //       '알림: ',
  //       isType != 'insert' ? '업데이트 성공.(${result})' : '추가 성공(${result})',
  //       backgroundColor: Colors.deepPurple[100],
  //     );
  //     setState(() {});
  //   }
  // }

  // showCalendar() async {

  //     DateTime? pickedDate  = await showDatePicker(
  //       context: context,
  //       initialDate: startDate==null?DateTime.now():startDate,    // 최초 선택된 날짜
  //       firstDate: DateTime(2025),
  //       lastDate: DateTime(2090),
  //       initialEntryMode: DatePickerEntryMode.calendarOnly,
  //       // locale: Locale('ko','KR'), // 항상 한국어로 표현
  //       // 영문 사용자는 영어로 되게 supportedLocales 로 설정해야 함.
  //     ).then((DateTime? value) async {
  //       if(value != null){
  //          final pickedTime= await showTimePicker(
  //         context: context,
  //         initialTime: startDate != null?  TimeOfDay(hour: startDate!.hour, minute: startDate!.minute) :TimeOfDay(hour: 22, minute: 10),

  //       );
  //         startDate =  DateTime(
  //           value.year,
  //           value.month,
  //           value.day,
  //           pickedTime!.hour,
  //           pickedTime.minute,
  //         );
  //       }

  //     });
  // }

  // // Reload
  // reload() async {
  //   final result = await db!.getTodoList();
  //   print("result ========= ${result}");
  //   setState(() {});
  // }

  // // update
  // updateTodoList(TodoList todolist) async{
  //   int result = await db!.updateTodoList(todolist);
  //   print('===== ${result}');
  //   if(result != 0){
  //     // Success
  //   }else{
  //     // Fail
  //   }

  // }
}
