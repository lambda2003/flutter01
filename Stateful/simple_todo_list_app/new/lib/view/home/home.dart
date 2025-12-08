// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:simple_todo_list_app/model/todo_list.dart';
// import 'package:simple_todo_list_app/util/today_report.dart';
// // import 'package:simple_todo_list_app/view/calendar_view.dart';
// // import 'package:simple_todo_list_app/view/deleted_list.dart';
// // import 'package:simple_todo_list_app/view/home_timer.dart';
// // import 'package:simple_todo_list_app/view/insert_todolist.dart';
// import 'package:simple_todo_list_app/view/helper/today_report_view.dart';
// // import 'package:simple_todo_list_app/view/today_report_view.dart';
// // import 'package:simple_todo_list_app/view/update_todolist.dart';
// import 'package:simple_todo_list_app/vm/database_handle.dart';

// class Homex extends StatefulWidget {
//   final DatabaseHandle db;
//   const Homex({super.key, required this.db});

//   @override
//   State<Homex> createState() => _HomeState();
// }

// class _HomeState extends State<Homex> {
//   // Property

//   late DatabaseHandle db;
//   late TextEditingController searchController;
//   late DateTime? startDate;
//   late Map<String, dynamic>? kwd;
//   int startNum = 0;
//   bool isAlarmOn = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     db = DatabaseHandle();
//     searchController = TextEditingController();
//     startDate = null;
//     kwd = {
//       "today": {"n": true},
//     };

//     // 초기 static 값을 셋팅하기 위해 필요.
//     reload();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     // timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     ;
//     return Scaffold(
//       // backgroundColor: isAlarmOnColor ? Colors.red : Colors.white,
//       appBar: AppBar(
//         title: Text('TODO LIST'),
//         actions: [
//           // IconButton(
//           //   onPressed: () => Get.to(DeletedList()),
//           //   icon: Icon(Icons.delete),
//           // ),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     if (TodayReport.alarmCount > 0) {
//           //       kwd = {'isAlarm': 1};
//           //       setState(() {});
//           //     } else {
//           //       showMessage(-115, '알람');
//           //     }
//           //   },
//           //   child: HomeTimer(isTurnOn: isAlarmOn, db: db),

//           //   // icon: isAlarmOn
//           //   //     ? Icon(Icons.notifications_active, color: Colors.red[400])
//           //   //     : Icon(Icons.notifications_off),
//           // ),
//           IconButton(
//             onPressed: () => Get.toNamed('/calendar'), //to(() => CalendarView(db: db)), //actionDialog('insert', null),
//             icon: Icon(Icons.calendar_month),
//           ),
//           IconButton(
//             onPressed: () => Get.toNamed(
//               '/insert',
//             )!.then((data) => reload()), //Get.to(InsertTodolist())!.then((data) => reload()), //actionDialog('insert', null),
//             icon: Icon(Icons.add_outlined),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               leading: Icon(Icons.today, color: Colors.black),
//               title: Text('오늘할일 (${TodayReport.count})'),
//               // subtitle: Text(''),
//               onTap: () {
//                 kwd = {
//                   "today": {"n": true},
//                 };
//                 setState(() {});
//                 Get.back();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.today, color: Colors.black),
//               title: Text('전체보기'),
//               // subtitle: Text(''),
//               onTap: () {
//                 kwd = null;
//                 setState(() {});
//                 Get.back();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.priority_high_outlined, color: Colors.red),
//               title: Text('중요일정 (${TodayReport.totalImportanceCount})'),
//               // subtitle: Text(''),
//               onTap: () {
//                 kwd = {'importance': 5};
//                 setState(() {});
//                 Get.back();
//               },
//             ),

//             ListTile(
//               leading: Icon(Icons.alarm_on),
//               title: Text('알람 켜져있는 일정 (${TodayReport.totalAlarmCount})'),
//               // subtitle: Text(''),
//               onTap: () {
//                 kwd = {'isAlarm': 1};
//                 setState(() {});
//                 Get.back();
//               },
//             ),
//             ListTile(
//               leading: isAlarmOn ? Icon(Icons.settings, color: Colors.amber[300]) : Icon(Icons.settings, color: Colors.grey[300]),
//               title: Text(isAlarmOn ? '알람 끄기' : '알람 켜기'),
//               // subtitle: Text(''),
//               onTap: () {
//                 isAlarmOn = !isAlarmOn;
//                 setState(() {});
//                 Get.back();
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 spacing: 5,
//                 children: [
//                   SizedBox(
//                     width: screenSize.width / 1.5,
//                     height: 40,
//                     child: TextField(
//                       controller: searchController,
//                       decoration: InputDecoration(
//                         labelText: '키워드를 넣어주세요.',
//                         labelStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       if (searchController.text.trim().isEmpty) {
//                         kwd = null;
//                       } else {
//                         kwd = {'name': searchController.text.trim()};
//                       }
//                       setState(() {});
//                     },
//                     visualDensity: VisualDensity.comfortable,

//                     style: IconButton.styleFrom(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),

//                       backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
//                       foregroundColor: Theme.of(context).colorScheme.onPrimary,
//                     ),
//                     icon: Icon(Icons.search),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       kwd = null;
//                       setState(() {});
//                     },
//                     visualDensity: VisualDensity.comfortable,
//                     style: IconButton.styleFrom(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
//                       backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//                       foregroundColor: Theme.of(context).colorScheme.secondary,
//                     ),
//                     icon: Icon(Icons.refresh),
//                   ),
//                 ],
//               ),
//             ),

//             // Align(
//             //   alignment: Alignment.centerLeft,
//             //   child: Padding(
//             //     padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//             //     child: Text(
//             //       kwd != null
//             //           ? '선택: ${TodayReport.titleMap[kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1)]}'
//             //           : '선택: 전체보기',
//             //     ),
//             //   ),
//             // ),
//             Container(
//               color: Theme.of(context).colorScheme.primaryContainer,
//               width: 400,
//               height: 50,
//               child: Row(
//                 spacing: 10,
//                 children: [
//                   Text(
//                     kwd != null ? '${TodayReport.titleMap[kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1)]}' : '전체보기',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Align(alignment: Alignment.centerRight, child: TodayReportView()),
//                 ],
//               ),
//             ),

//             SizedBox(
//               height: 500,
//               child: FutureBuilder(
//                 future: db.getTodoList(kwd, TableName.todolist, startNum), //db!.getTodoList(null, TableName.todolist,startNum),
//                 builder: (context, snapshot) {
//                   return
//                   // snapshot.hasData ?
//                   snapshot.data == null || snapshot.data!.length == 0
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('No Data'),
//                               IconButton(
//                                 onPressed: () {
//                                   kwd = null;
//                                   setState(() {});
//                                 },

//                                 icon: Icon(Icons.refresh_rounded),
//                               ),
//                             ],
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: snapshot.data != null ? snapshot.data!.length : 0,
//                           itemBuilder: (context, index) {
//                             return Slidable(
//                               endActionPane: ActionPane(
//                                 motion: BehindMotion(),
//                                 children: [
//                                   SlidableAction(
//                                     onPressed: (context) => deleteAction(snapshot.data![index].id!),
//                                     backgroundColor: Colors.red,
//                                     icon: Icons.delete_outline,
//                                     label: 'Delete',
//                                   ),
//                                 ],
//                               ),
//                               child: GestureDetector(
//                                 onTap: () => Get.toNamed('/update', arguments: snapshot.data![index])!.then((data) => reload()),
//                                 //Get.to(UpdateTodolist(), arguments: snapshot.data![index])!.then((data) => reload()),
//                                 // actionDialog('update', snapshot.data![index]),
//                                 child: SizedBox(
//                                   width: screenSize.width - 8,

//                                   child: Card(
//                                     color: snapshot.data![index].isDeleted == 1 ? Colors.grey[300] : Colors.grey[100],
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         spacing: 10,
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           Icon(Icons.calendar_month, size: 35),

//                                           Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text('${snapshot.data![index].title}'),
//                                               Text(
//                                                 'Date : ${snapshot.data![index].startDate != null ? snapshot.data![index].startDate!.toString().substring(0, 16) : ''}',
//                                               ),

//                                               Row(
//                                                 children: [
//                                                   Text('중요한 약속 (${snapshot.data![index].importance})'),

//                                                   snapshot.data![index].importance! >= 6 ? Icon(Icons.priority_high, color: Colors.red) : Text(''),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),

//                                           Container(
//                                             width: screenSize.width / 3,
//                                             alignment: Alignment.centerRight,
//                                             child: Column(
//                                               children: [
//                                                 snapshot.data![index].isAlarm == 1
//                                                     ? Icon(Icons.lightbulb, color: Colors.amber)
//                                                     : Icon(Icons.lightbulb, color: Colors.grey[500]),

//                                                 // kwd!=null && kwd!.keys.toString().substring(1, kwd!.keys.toString().length - 1) == 'isAlarm' ?
//                                                 snapshot.data![index].isDeleted == 0
//                                                     ? ElevatedButton(onPressed: () => toggleAlarmAction(snapshot.data![index]), child: Text('알람'))
//                                                     : Text('알람', style: TextStyle(fontSize: 13)),
//                                               ],
//                                             ),
//                                           ),
//                                           // Switch(

//                                           //   value: snapshot.data![index].isAlarm==1?true:false, onChanged: null)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                   // : Center(child: const CircularProgressIndicator());
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // == Functions
//   deleteAction(int id) async {
//     final int result = await db.deleteTodoList(id);
//     reload();
//     showMessage(result, '삭제');
//     // Get.to(DeletedList())!.then((value) => setState(() {}));
//   }

//   toggleAlarmAction(TodoList todolist) async {
//     int now = DateTime.now().millisecondsSinceEpoch;
//     if (todolist.isAlarm == 0 && todolist.startDate!.millisecondsSinceEpoch < now) {
//       showMessage(-110, '알람변경');
//       return;
//     }
//     int result = await db.toggleAlarm(todolist);
//     if (result != 0) reload();
//     showMessage(result, '알람변경');
//   }

//   // 모든 DB 변경이 일어나면 실행시킨다.
//   // - 추후 다른 페이지에서도 볼수 있게 Static으로 저장
//   reload() async {
//     List<int> data = await db.getTodayReport();
//     TodayReport.alarmCount = data[0]; // today alarmcount
//     TodayReport.importantCount = data[1]; // today importance
//     TodayReport.count = data[2]; // today count
//     TodayReport.totalImportanceCount = data[3]; // total importance count
//     TodayReport.totalAlarmCount = data[4]; // totalAlarmCount
//     setState(() {});
//   }

//   // TODO: GT=> 에러코드에 대한 정의가 필요
//   /*
//     -110은 toggle에서 validation fail됬을시 에러.
//   */
//   showMessage(int i, String msg) {
//     if (i == 0) {
//       Get.snackbar('에러', '$msg에 에러가 발생했습니다.', backgroundColor: Colors.red);
//     } else {
//       if (i == -110) {
//         Get.snackbar('알림', '$msg일 불가합니다. 날짜를 변경하세요.', backgroundColor: Colors.orange[500]);
//       } else if (i == -115) {
//         Get.snackbar(
//           '알림',
//           '오늘 $msg 내용이 없습니다.',
//           // backgroundColor: Colors.orange[500],
//         );
//       } else {
//         Get.snackbar('알림', '$msg에 성공했습니다.', backgroundColor: Colors.green[500]);
//       }
//     }
//   }
// }
