import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

/***
  Timer Infinite Loop
  - 오류가 생겼을시 헨들해 주어야 한다.
  - 
 */

class HomeTimer extends StatefulWidget {
  final bool isTurnOn;
  final DatabaseHandle db;
  const HomeTimer({super.key, required this.isTurnOn, required this.db});

  @override
  State<HomeTimer> createState() => _HomeTimerState();
}

class _HomeTimerState extends State<HomeTimer> {

  late Timer timer;
  bool isWorking = false;
  int loopCount = 1;
  int alarmCount = 0;
  bool boolColorChange = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    timer = Timer.periodic(Duration(seconds: 5), (time) => alarmCheck());
    //  timer.cancel();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // return Row(
    //   children: [
    //     alarmCount> 0
    //     ? Icon(Icons.notifications_active, color: Colors.red[400])
    //     : Icon(Icons.notifications_off),
        
    //     alarmCount > 0 
    //     ? boolColorChange? Text('30분전 ($alarmCount)',style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold)) : Text('30분전 ($alarmCount)',style:TextStyle(color: Colors.black))
        
    //     : Text('${alarmCount}'),
    //   ],
    // );
    return  alarmCount> 0
        ? Row(
      children: [
        boolColorChange? Icon(Icons.notifications_active, color: Colors.red[400]): Icon(Icons.notifications_active, color: Colors.red[100]) ,
        boolColorChange? Text('30분전 ($alarmCount)',style:TextStyle(color: Colors.black)) : Text('30분전 ($alarmCount)',style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold))
 
      ],
    )
    :     
    Row(
      children: [
        Icon(Icons.notifications_off),
         Text('${alarmCount}'),
      ],
    );
  }

  // == functions

  alarmCheck() async {
    print('======== HomeTimer => alarmCheck() => called');
    print('======== HomeTimer => alarmCheck() => loopCount = ${loopCount}');
    loopCount++;
     if (loopCount > 500) {
      timer.cancel();
      loopCount = 1;
      print('======== HomeTimer => alarmCheck() => Timer Destroyed by Loop Count  ========');
      setState(() {});
    }
    if(!widget.isTurnOn) {
      if(alarmCount!=0){
        alarmCount = 0;
        print('======== HomeTimer => alarmCheck() =>isTurnOn => off => setState');
        setState(() {});
      }
      return;
    }


    // 오늘자 알람리스트를 가져온다.
    List<TodoList> data = await widget.db.getTodoList(
      {"today": {"n":true}},
      TableName.todolist_alarm,
      0,
    );
    if (data.length == 0) {
      print('======== HomeTimer => alarmCheck() => DATA: 0');
      if(alarmCount!=0){
        alarmCount = 0;
        print('======== HomeTimer => alarmCheck() => DATA: 0 => setState');
        setState(() {});
      }
      return;
      
    }
    print('==================================================');
    print('======== HomeTimer => alarmCheck() => CODE RUN');
    print('==================================================');

    DateTime now = DateTime.now();
    int xcount = 0;
    for (int i = 0; i < data.length; i++) {
      TodoList d = data[i];

      if (d.startDate != null &&
          now.subtract(Duration(minutes: 30)).millisecondsSinceEpoch <=
              d.startDate!.millisecondsSinceEpoch) {
        if (now.millisecondsSinceEpoch < d.startDate!.millisecondsSinceEpoch) {
          xcount++;
        } else {
          // 알람을 끈다.

          int result = await widget.db.deleteAalarm(d.id!);
          if (result != 100) {
            timer.cancel();
            loopCount = 1;
            print('======== ERROR: HomeTimer => alarmCheck() => Timer Destroyed by DELETE ERROR ========');
            break;
          } else {
            xcount--;
          }
        }
      }
    }
    boolColorChange = !boolColorChange;
    if (alarmCount != xcount && xcount>=0) {
      alarmCount = xcount;
      print('======== HomeTimer => alarmCheck() => setState()  ========');
    }
    setState(() {});


  }
}
