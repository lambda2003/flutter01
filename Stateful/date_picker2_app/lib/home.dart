import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String currentDateTime;
  DateTime? chosenDateTime;
  late bool _isRunning;
  late Timer _timer;
  bool _isAlram = false;
  bool _isStart = false;
  bool _isBlank = false;
  DateTime? alarmSetTime;
  @override
  void initState() {
    super.initState();
    currentDateTime = '';
    chosenDateTime = null;
    alarmSetTime = null;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) {
        print('Timer cancelled =====');
        timer.cancel();
      }
      _addItem();
    });
  }

  _addItem() {
    // 현재 시간
    DateTime now = DateTime.now();
    currentDateTime =
        '${now.year}-${now.month.toString().padLeft(2, '0')}' +
        '-${now.day.toString().padLeft(2, '0')}' +
        ' ${_weekDayToString(now.weekday)}' +
        ' ${now.hour.toString().padLeft(2, '0')}' +
        ':${now.minute.toString().padLeft(2, '0')}' +
        ':${now.second.toString().padLeft(2, '0')}';
    // 알람이지 SET 그리고 Alram 준비
    if (alarmSetTime != null &&
        !_isStart &&
        _isAlram &&
        alarmSetTime!.millisecondsSinceEpoch <= now.millisecondsSinceEpoch) {
      _isStart = true;
    }
    if (alarmSetTime != null &&
        now.millisecondsSinceEpoch <
            alarmSetTime!
                .add(const Duration(minutes: 1))
                .millisecondsSinceEpoch) {
      // 알람 1분 이내, 깜빡이게 하기 위함.
      _isBlank = !_isBlank;
    } else {
      // 1분 후에 자동으로  알람이 멈추게 하기 위함.
      _isBlank = false;
      _isAlram = false;
      _isStart = false;
    }

    setState(() {});
  }

  String _weekDayToString(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      default:
        return '일';
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isStart
          ? _isBlank
                ? Colors.red
                : Colors.white
          : Colors.white,
      appBar: AppBar(title: Text('date picker 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 시간: ${currentDateTime}'),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                // showTimeSeparator: true,
                onDateTimeChanged: (value) async {
                  chosenDateTime = value;
                },
              ),
            ),
            Text(
              '선택시간 :  ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : '시간을 선택하세요.'}',
              style: TextStyle(), //${chosenDateTime.toString()}'
            ),
            Text(
              '알람시간 :  ${alarmSetTime != null ? alarmSetTime.toString() : '알람이 비어있습니다.'}',
              style: TextStyle(), //${chosenDateTime.toString()}'
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () async => await resetAlram(false),
                  child: Text('알림 설정'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () => resetAlram(true),
                  child: Text('알람 지우기'),
                ),
              ],
            ),

            // _isAlram && _isStart
            //     ? ElevatedButton(
            //         onPressed: () => resetAlram(true),
            //         child: Text('Stop Alram'),
            //       )
            //     : ElevatedButton(
            //         onPressed: () async => await resetAlram(false),
            //         child: Text('Set Alram'),
            //       ),
          ],
        ),
      ),
    );
  }

  // == functions
  String _chosenItem(DateTime now) {
    String xx =
        '${now.year}-${now.month.toString().padLeft(2, '0')}' +
        '-${now.day.toString().padLeft(2, '0')}' +
        ' ${_weekDayToString(now.weekday)}' +
        ' ${now.hour.toString().padLeft(2, '0')}' +
        ':${now.minute.toString().padLeft(2, '0')}';

    return xx;
  }

  resetAlram(bool isReset) async {
    if (isReset) {
      _isAlram = false;
      _isStart = false;
      alarmSetTime = null;
      setState(() {});
    } else {

      await Get.defaultDialog(
        barrierDismissible: false,
        title: alarmSetTime != null ? '알람 재설정' : '알람을 설정',
        content: Text(
          alarmSetTime != null
              ? '기존 알람이 존재 합니다. 재설정 하시겠니까?\n'
                    '기존 알람은 ${alarmSetTime} 입니다.\n'
                    '재설정될 알람은 ${chosenDateTime} 입니다.'
              : '알람 설정을 하시겠습니까?\n'
                    '설정된 알람은 ${chosenDateTime} 입니다.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // 알람을 리셋
              alarmSetTime = chosenDateTime;
              _isAlram = true;
              _isStart = false;

              setState(() {});
              Get.back();
            },
            child: Text('네'),
          ),
          ElevatedButton(
            onPressed: () {
              // 기존것 유지
              Get.back();
            },
            child: Text('아니오'),
          ),
        ],
      );
    }
  }
}
