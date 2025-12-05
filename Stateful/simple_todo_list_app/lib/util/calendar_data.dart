import 'package:flutter/material.dart';

class CalendarData {
  static List<DateTime> holidayList = [
    DateTime.utc(2025, 10, 3),
    DateTime.utc(2025, 10, 9),
    DateTime.utc(2025, 12, 25),
  ];
  static Map<String,dynamic> colors =  
  {
    'weekendText': Colors.grey[500],
    'defaultText': Colors.grey[800],
    'holidayDecorationColor': Colors.red[100], // 쉬는 날 Background Color
  };
}
