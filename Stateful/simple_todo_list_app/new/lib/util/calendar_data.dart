import 'dart:collection';

import 'package:flutter/material.dart';

class CalendarData {
  static List<DateTime> holidayList = [
    DateTime.utc(2025, 10, 3),
    DateTime.utc(2025, 10, 9),
    DateTime.utc(2025, 12, 25),
    DateTime.utc(2026, 1, 1),
    DateTime.utc(2026, 2, 16),
    DateTime.utc(2026, 2, 17),
    DateTime.utc(2026, 2, 18),
    DateTime.utc(2026, 3, 2),
  ];
  static LinkedHashMap<DateTime, String> holidayListMap = LinkedHashMap<DateTime, String>()
    ..addAll({
      DateTime.utc(2025, 10, 3): '',
      DateTime.utc(2025, 10, 9): '',
      DateTime.utc(2025, 12, 25): '크리스마스',
      DateTime.utc(2026, 1, 1): '신정(양력설)',
      DateTime.utc(2026, 2, 16): '설날 연휴일',
      DateTime.utc(2026, 2, 17): '설날(음력설)',
      DateTime.utc(2026, 2, 18): '설날 연휴일',
      DateTime.utc(2026, 3, 1): '3.1광복절',
      DateTime.utc(2026, 3, 2): '대체공휴일',
    });

  static Map<String, dynamic> colors = {
    'weekendText': Colors.grey[500],
    'defaultText': Colors.grey[800],
    'holidayDecorationColor': Colors.red[100], // 쉬는 날 Background Color
  };
}
