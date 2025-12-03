import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/view/deleted_list.dart';
import 'package:simple_todo_list_app/view/insert_todolist.dart';
import 'package:simple_todo_list_app/view/update_todolist.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';
import 'package:sqflite/sqlite_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  DatabaseHandle? db;
  late TextEditingController searchController;
  late DateTime? startDate;
  late Map<String, dynamic>? kwd;
  int startNum = 0;
  late Timer timer;
  bool isWorking = false;
  int loopCount = 0;
  bool isAlramOnColor = false;
  bool isAlramOn = false;
  List<TodoList> alarmList = [];


  // int dropDownValue = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
    searchController = TextEditingController();
    startDate = null;
    kwd = null;
    timer = Timer.periodic(Duration(seconds:5), (time)=>alarmCheck());

  }

  @override
  void dispose() {
    searchController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isAlramOnColor ? Colors.red:Colors.white,
      appBar: AppBar(
        title: Text('TODO LIST'),
        actions: [
          IconButton(
            onPressed: () => Get.to(DeletedList()),
            icon: Icon(Icons.delete),
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
              title: Text('최근순으로'),
              // subtitle: Text(''),
              onTap: () {
                kwd = null;
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.today, color: Colors.black),
              title: Text('중요일정'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'importance': 1};
                setState(() {});
                Get.back();
              },
            ),

            ListTile(
              leading: Icon(Icons.today, color: Colors.black),
              title: Text('알람켜있는 것들'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'isAlram': 1};
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
                    width: 280,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(labelText: '키워드를 넣어주세요.',labelStyle: TextStyle(
                        fontSize:13, color: Colors.grey[500]
                      )),
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
                    
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        
                      ),
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    
                    ),
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      kwd = null;
                      setState(() {});
                    },
                    
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    
                    ),
                    icon: Icon(Icons.reset_tv_outlined),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: db!.getTodoList(
                  null,
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
                                    ElevatedButton(
                                      onPressed: () {
                                        kwd = null;
                                        setState(() {});
                                      },
                                      child: Text('Go back'),
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
                                        width: 400,
                                  
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              spacing: 10,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.calendar_month,size:35),

                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Title : ${snapshot.data![index].title}',
                                                    ),
                                                    Text(
                                                  'Date : ${snapshot.data![index].startDate != null ? snapshot.data![index].startDate!.toString().substring(0, 16) : ''}',
                                                ),
                                                    
                                                    Row(children: [
                                                      Text('중요도: '),
                                                      Text('${snapshot.data![index].importance}'),
snapshot.data![index].importance!>=6? Icon(Icons.priority_high,color: Colors.red,) :  Text(''),

                                                    ],)
                                                    
                                                    



                                                  ],
                                                ),
                                                
                                                
                                               
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
    final int result = await db!.deleteTodoList(id);
    Get.to(DeletedList())!.then((value) => setState(() {}));
  }

  alarmCheck() async {
    print('==called');
    
    if(loopCount>10){
      isAlramOn = false;
      isAlramOnColor = false;
      timer.cancel();
      print('타이머 cancelled========');
      setState(() {
        
      });
      
    }
  
    if(!isWorking && !isAlramOn){
      isWorking = true;
      List<TodoList> data = await db!.getTodoList({"isAlram":1}, TableName.todolist, 0);
      DateTime now = DateTime.now();
      
      for(int i=0;i<data.length;i++){
        TodoList d = data[i];
        print(now.subtract(Duration(minutes: 30)).toString());
        print(d.startDate!.toString());
        print(now.subtract(Duration(minutes: 30)).millisecond.toString());
        print(d.startDate!.microsecond.toString());
        if(d.startDate!=null && now.subtract(Duration(minutes: 30)).millisecondsSinceEpoch <= d.startDate!.millisecondsSinceEpoch
        
        ) {
          if(now.millisecondsSinceEpoch < d.startDate!.millisecondsSinceEpoch){
            print('알람..알람..알람.');
            isAlramOnColor = !isAlramOnColor;
            isAlramOn = true;
          }else{
            // 알람을 끈다.
            d.isAlram = 0;
            isAlramOnColor = false;
            isAlramOn = false;
            await db!.updateTodoList(d, TableName.todolist);
          }
        }

        print('=== hitted == ${loopCount}');
      }
    }
    print('isAlramon:${isAlramOn}');
      if(isAlramOn){
       isAlramOnColor = !isAlramOnColor;
       setState(() {
         
       });
    }
    loopCount++;
    isWorking = false;
  }
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
  reload() {
    // list = db!.getTodoList(null, TableName.todolist,startNum);
    setState(() {});
  }

  resultHandle(String isType, int result) {
    if (result == 0) {
      Get.snackbar(
        isType != 'insert' ? '업데이트 하는 동안 에러가 발생했습니다.' : '추가하는 동안 에러가 발생했습니다.',
        '다시 시도해 보세요.',
      );
    } else if (result == -1) {
      Get.back();
      Get.snackbar(
        '알림: ',
        isType != 'insert' ? '업데이트 성공(${result}).' : '추가 성공',
        backgroundColor: Colors.deepPurple[100],
      );
    } else {
      Get.back();
      Get.snackbar(
        '알림: ',
        isType != 'insert' ? '업데이트 성공.(${result})' : '추가 성공(${result})',
        backgroundColor: Colors.deepPurple[100],
      );
      setState(() {});
    }
  }

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
