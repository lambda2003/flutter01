import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

// flutter local notification use this page.
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
/***
  Timer Infinite Loop

  TODO: 
  - 오류가 생겼을시 헨들해 주어야 한다.
  - DB접속을 최소한으로 한다. 
 */

class HomeTimer extends StatefulWidget {
  final bool isTurnOn;
  final DatabaseHandle db;
  final FlutterLocalNotificationsPlugin localNotification;
  const HomeTimer({super.key, required this.isTurnOn, required this.db, required this.localNotification});

  @override
  State<HomeTimer> createState() => _HomeTimerState();
}

// WidgetBindingObserve
// with WidgetsBindingObserver
class _HomeTimerState extends State<HomeTimer> {
  late Timer timer;
  bool isWorking = false;
  int loopCount = 1;
  int alarmCount = 0;
  bool boolColorChange = false;
  List<int> notificationList = [];

  late NotificationDetails _detail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addObserver(this);

    _detail = NotificationDetails(
      android: AndroidNotificationDetails('TodoListChannelID-1', 'TodoListChannelID-1-name'),
      iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
    );

    timer = Timer.periodic(Duration(seconds: 5), (time) => alarmCheck());
    //  timer.cancel();
    // selectedDatePushAlarm(2, "TEST TITLE", "Test Body", DateTime.now());
  }

  @override
  void dispose() {
    widget.localNotification.cancelAll();
    timer.cancel();
    // WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.paused) {
  //     // App is in the background
  //     print('App is in the background');
  //   } else if (state == AppLifecycleState.resumed) {
  //     // App is in the foreground
  //     print('App is in the foreground');
  //   } else if (state == AppLifecycleState.inactive) {
  //     // App is inactive (e.g., system dialog open)
  //     print('App is inactive');
  //   } else if (state == AppLifecycleState.detached) {
  //     // App is terminated
  //     print('App is terminated');
  //   }
  // }

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
    return alarmCount > 0
        ? Row(
            children: [
              boolColorChange ? Icon(Icons.notifications_active, color: Colors.red[400]) : Icon(Icons.notifications_active, color: Colors.red[100]),
              boolColorChange
                  ? Text('30분전 ($alarmCount)', style: TextStyle(color: Colors.black, fontSize: 12))
                  : Text(
                      '30분전 ($alarmCount)',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    // ElevatedButton(onPressed: ()=>selectedDatePushAlarm(2, "TEST TITLE", "Test Body", DateTime.now()), child: Text('test'))
            ],
          )
        : Row(children: [Icon(Icons.notifications_off), Text('${alarmCount}'),
        
          // ElevatedButton(onPressed: ()=> sendNotification(1, '약속 테스트', '${DateTime.now()}'), child: Text('SEND'))
        
        ]);
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
    if (!widget.isTurnOn) {
      if (alarmCount != 0) {
        alarmCount = 0;
        print('======== HomeTimer => alarmCheck() =>isTurnOn => off => setState');
        setState(() {});
      }
      print('======== HomeTimer => alarmCheck() =>isTurnOn => off => setState');
      return;
    }
    // 1분마다 데이터 베이스와 싱크
    if (loopCount == 3 || loopCount % 12 == 0) {
      print('======== HomeTimer => alarmCheck() =>isTurnOn => on => GETDATA FROM DB');
      List<TodoList> returnData = await widget.db.getTodoList(
        {
          "today": {"n": true, "datetime": DateTime.now()},
        },
        TableName.todolist_alarm,
        0,
      );
      TodayReport.data = returnData;
    }
    // print('${data[0].isAlarm}======');
    // print('${data[0].startDate}======');
    if (TodayReport.data.length == 0) {
      print('======== HomeTimer => alarmCheck() => DATA: 0');
      if (alarmCount != 0) {
        alarmCount = 0;
        print('======== HomeTimer => alarmCheck() => DATA: 0 => setState');
        setState(() {});
      }
      return;
    }
    print('==================================================');
    print('======== HomeTimer => alarmCheck() => CODE RUN');
    print('==================================================');
    print('======== notification.length: ${notificationList.length}');
    DateTime now = DateTime.now();
    int xcount = 0;
    for (int i = 0; i < TodayReport.data.length; i++) {
      TodoList d = TodayReport.data[i];

      if (d.startDate != null && now.subtract(Duration(minutes: 30)).millisecondsSinceEpoch <= d.startDate!.millisecondsSinceEpoch) {
        if (now.millisecondsSinceEpoch < d.startDate!.millisecondsSinceEpoch &&
            now.millisecondsSinceEpoch > d.startDate!.subtract(Duration(minutes: 30)).millisecondsSinceEpoch) {
          xcount++;
          if (!notificationList.contains(d.id!)) {
            sendNotification(d.id!, '약속 ${d.title}', '${d.startDate}');
          }
        } else {
          // 알람을 끈다.
          if (now.millisecondsSinceEpoch > d.startDate!.millisecondsSinceEpoch) {
            int result = await widget.db.deleteAalarm(d.id!);
            if (result == 0) {
              timer.cancel();
              loopCount = 1;
              print('======== ERROR: HomeTimer => alarmCheck() => Timer Destroyed by DELETE ERROR ========');
              break;
            } else {
              TodayReport.count--;

              if (d.importance! > 5) TodayReport.importantCount--;
              if (d.isAlarm != 0) TodayReport.alarmCount--;
              xcount--;
              notificationList.remove(d.id!);
              TodayReport.data.removeAt(i);
            }
          }
        }
      }
    }
    boolColorChange = !boolColorChange;
    if (alarmCount != xcount && xcount >= 0) {
      alarmCount = xcount;
      print('======== HomeTimer => alarmCheck() => setState()  ========');
    }
    setState(() {});
  }

  // === Functions
  sendNotification(int id, String title, String body) async {
    notificationList.add(id);
    await widget.localNotification.show(id, '알람 ${title}', '${body}', _detail, payload: 'deepLink').then((d){
      print('aaa done');
    });
  }

  // 특정 시간대 전송.

  Future<void> selectedDatePushAlarm(int id, String title, String body, DateTime dateTime) async {
    // FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();
    widget.localNotification.cancelAll();
    final scheduledTime = tz.TZDateTime(
      tz.getLocation('Asia/Seoul'),
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute + 2,
    );
    await widget.localNotification.zonedSchedule(
      1,
      '로컬 푸시 알림 2',
      '특정 날짜 / 시간대 전송 알림',

      scheduledTime,
      _detail,

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      // 셋팅된 시간에 매일 발송
      // matchDateTimeComponents: DateTimeComponents.time,

      // 주간
      // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,

      // 월간
      // matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }
}
