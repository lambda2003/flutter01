// import 'package:flutter/material.dart';
// import 'package:simple_todo_list_app/model/todo_list.dart';
// import 'package:simple_todo_list_app/util/today_report.dart';
// import 'package:simple_todo_list_app/vm/database_handle.dart';

// class TodayReportView extends StatefulWidget {
//   final DatabaseHandle db;
//   const TodayReportView({super.key,required this.db});

//   @override
//   State<TodayReportView> createState() => _TodayReportViewState();
// }

// class _TodayReportViewState extends State<TodayReportView> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//   }

//   initRun() async {
//     // Get DB from today's report
//     // List<TodoList> todayList = await widget.db.getTodoList({"today":{"n":false}},TableName.todolist, 0);
//     // print('=-=-=-=-=-=-=-=-=-=${todayList.length}===');
//     // for(TodoList d in todayList){
//     //   if(d.isAlarm !=0) TodayReport.alarmCount++;
//     //   if(d.importance! > 5) TodayReport.importantCount++;
//     //   TodayReport.count++;
//     // }
//     List<int> data = await widget.db.getTodayReport();
//     TodayReport.alarmCount = data[0];// today alarmcount
//     TodayReport.importantCount = data[1];// today importance
//     TodayReport.count = data[2]; // today count

//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Text('오늘일정: ${TodayReport.count}개, 중요일정: ${TodayReport.importantCount}');
//   }
// }

import 'package:flutter/material.dart';
import 'package:simple_todo_list_app/util/today_report.dart';

class TodayReportView extends StatelessWidget {
  const TodayReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '오늘 (일정 총: ${TodayReport.count}개 중요일정: ${TodayReport.importantCount}, 알람: ${TodayReport.alarmCount})',
      ),
    );
  }

  /*
Align(
      alignment: Alignment.centerRight,
      child: Text(
        '오늘 (총일정: ${TodayReport.count}개, 중요 일정: ${TodayReport.importantCount})',
      ),
    );
  */
}
