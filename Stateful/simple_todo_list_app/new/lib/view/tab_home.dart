import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/util/common_functions.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/view/calendar_view.dart';
import 'package:simple_todo_list_app/view/helper/home_timer.dart';
import 'package:simple_todo_list_app/view/home.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class TabHome extends StatefulWidget {
  DatabaseHandle db;
  TabHome({super.key, required this.db});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with SingleTickerProviderStateMixin {
  late TabController controller;
  bool isAlarmOn = true;
  late Map<String, dynamic>? kwd;
  late FlutterLocalNotificationsPlugin localNotification;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    kwd = {
      "today": {"n": true, "datetime": DateTime.now()},
    };
    localNotification = FlutterLocalNotificationsPlugin();
    _initLocalNotification();
    reload();
  }
  
  Future<void> _initLocalNotification() async {
     localNotification = FlutterLocalNotificationsPlugin();
    // final AndroidInitializationSettings initSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    AndroidInitializationSettings initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initSettings = InitializationSettings(android: initSettingsAndroid, iOS: initSettingsIOS);
    await localNotification.initialize(initSettings);
     final bool? granted = await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted != null && granted) {
      print('알림 권한이 허용되었습니다.');
    } else {
      print('알림 권한이 거부되었습니다.');
    }
  }
  // Future<void> _initLocalNotification() async {
  //   localNotification = FlutterLocalNotificationsPlugin();
    
  //   AndroidInitializationSettings initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   DarwinInitializationSettings initSettingsIOS = const DarwinInitializationSettings(
  //     requestSoundPermission: true,
  //     requestBadgePermission: true,
  //     requestAlertPermission: true,
  //   );
  //   InitializationSettings initSettings = InitializationSettings(android: initSettingsAndroid, iOS: initSettingsIOS);
  //   await localNotification.initialize(initSettings);

  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=== TabHOme === rebuild');
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 100,
            height: 35,
            child: HomeTimer(isTurnOn: isAlarmOn, db: widget.db, localNotification: localNotification),
            // ElevatedButton(
            //   onPressed: () {
            //     kwd = {
            //       "today": {"n": true, "datetime": DateTime.now()},
            //     };
            //     if (controller.index != 0) {
            //       controller.animateTo(0);
            //     }
            //     setState(() {});
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //     padding: EdgeInsets.all(0),
            //   ),
            //   child: HomeTimer(isTurnOn: isAlarmOn, db: widget.db, localNotification: localNotification),
            // ),
          ),

          IconButton(
            onPressed: () => Get.toNamed(
              '/insert',
            )!.then((data) => reload()), //Get.to(InsertTodolist())!.then((data) => reload()), //actionDialog('insert', null),
            icon: Icon(Icons.add_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.red,
            labelStyle: TextStyle(fontSize: 12),

            tabs: [
              Tab(icon: Icon(Icons.schedule_outlined), text: 'LIST'),
              Tab(icon: Icon(Icons.calendar_month), text: 'CALENDAR'),
            ],
          ),
        ),
      ),

      drawer: Drawer(
        width: 230,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.today, color: Colors.black),
              title: Text('오늘할일(${TodayReport.count})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {
                  "today": {"n": true, "datetime": DateTime.now()},
                };
                if (controller.index != 0) {
                  controller.animateTo(0);
                }
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
                if (controller.index != 0) {
                  controller.animateTo(0);
                }
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.priority_high_outlined, color: Colors.red),
              title: Text('중요일정(${TodayReport.totalImportanceCount})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'importance': 5};
                if (controller.index != 0) {
                  controller.animateTo(0);
                }
                setState(() {});
                Get.back();
              },
            ),

            ListTile(
              leading: Icon(Icons.alarm_on),
              title: Text('알람일정(${TodayReport.totalAlarmCount})'),
              // subtitle: Text(''),
              onTap: () {
                kwd = {'isAlarm': 1};
                if (controller.index != 0) {
                  controller.animateTo(0);
                }
                setState(() {});
                Get.back();
              },
            ),
            ListTile(
              leading: isAlarmOn ? Icon(Icons.settings, color: Colors.amber[300]) : Icon(Icons.settings, color: Colors.grey[300]),
              title: Text(isAlarmOn ? '알람 끄기' : '알람 켜기'),
              // subtitle: Text(''),
              onTap: () {
                isAlarmOn = !isAlarmOn;
                if (controller.index != 0) {
                  controller.animateTo(0);
                }
                setState(() {});
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Home(db: widget.db, kwd: kwd, onReload: () => reload()),
          CalendarView(db: widget.db),
        ],
      ),
    );
  }

  // Functions
  // Todo: Tab으로 변경 후 Home이랑 중복된 함수
  reload() async {
    await CommonFunctions.reload(widget.db);
    setState(() {});
  }
}
