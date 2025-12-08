import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class CommonFunctions {
  static showMessage(int i, String msg) {
    if (i == 0) {
      Get.snackbar('에러', '$msg에 에러가 발생했습니다.', backgroundColor: Colors.red);
    } else {
      if (i == -110) {
        Get.snackbar('알림', '$msg일 불가합니다. 날짜를 변경하세요.', backgroundColor: Colors.orange[500]);
      } else if (i == -115) {
        Get.snackbar(
          '알림',
          '오늘 $msg 내용이 없습니다.',
          // backgroundColor: Colors.orange[500],
        );
      } else if (i == -120) {
        // 입력관련에러
        // 날짜변경 validation fail
        Get.snackbar('알림', '$msg을 입력해 주세요.', backgroundColor: Colors.orange[500]);
      } else {
        Get.snackbar('알림', '$msg에 성공했습니다.', backgroundColor: Colors.green[500]);
      }
    }
  }

  static reload(DatabaseHandle db) async {
    List<int> data = await db.getTodayReport(DateTime.now());
    TodayReport.alarmCount = data[0]; // today alarmcount
    TodayReport.importantCount = data[1]; // today importance
    TodayReport.count = data[2]; // today count
    TodayReport.totalImportanceCount = data[3]; // total importance count
    TodayReport.totalAlarmCount = data[4]; // totalAlarmCount
  }
}
