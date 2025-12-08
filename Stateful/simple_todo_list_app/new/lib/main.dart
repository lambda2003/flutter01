import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// import 'package:simple_todo_list_app/view/calendar_view.dart';
// import 'package:simple_todo_list_app/view/home.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_todo_list_app/view/home/insert_todolist.dart';
import 'package:simple_todo_list_app/view/home/update_todolist.dart';
import 'package:simple_todo_list_app/view/tab_home.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // Notification timezone setting
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  // await _initLocalNotification();

  DatabaseHandle db = DatabaseHandle();
  initializeDateFormatting().then((_) => runApp(MyApp(db: db)));
}
// void main() {
//   runApp(const MyApp());
// }


  // Future<void> _initLocalNotification() async {
  //   FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();
  //   // final AndroidInitializationSettings initSettingsAndroid =
  //   //     AndroidInitializationSettings('app_icon');
  //   AndroidInitializationSettings initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   DarwinInitializationSettings initSettingsIOS = const DarwinInitializationSettings(
  //     requestSoundPermission: true,
  //     requestBadgePermission: true,
  //     requestAlertPermission: true,
  //   );
  //   InitializationSettings initSettings = InitializationSettings(android: initSettingsAndroid, iOS: initSettingsIOS);
  //   await localNotification.initialize(initSettings);
  //    final bool? granted = await localNotification
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();

  //   if (granted != null && granted) {
  //     print('알림 권한이 허용되었습니다.');
  //   } else {
  //     print('알림 권한이 거부되었습니다.');
  //   }
  // }


class MyApp extends StatelessWidget {
  final DatabaseHandle db;
  const MyApp({super.key, required this.db});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: TabHome(db: db),
      // initialRoute: '/',
      getPages: [
        // GetPage(
        //   name: '/',
        //   page: () => Home(db: db),
        // ),
        GetPage(
          name: '/insert',
          page: () => InsertTodolist(db: db),
        ),
        GetPage(
          name: '/update',
          page: () => UpdateTodolist(db: db),
        ),
        // GetPage(
        //   name: '/calendar',
        //   page: () => CalendarView(db: db),
        // ),
      ],

      // home: const Home(db:db),
    );
  }
}
