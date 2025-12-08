import 'package:simple_todo_list_app/model/todo_list.dart';

class TodayReport {
  static int count = 0;
  static int importantCount = 0;
  static int alarmCount = 0;
  static int totalImportanceCount = 0;
  static int totalAlarmCount = 0;
  static final Map<String, dynamic> titleMap = {'today': '오늘할일', 'isAlarm': '알람 리스트', 'importance': '중요 리스트', 'name': '서치결과'};
  static List<TodoList> data = [];
}
