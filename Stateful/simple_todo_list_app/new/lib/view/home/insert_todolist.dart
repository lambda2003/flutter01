import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/common_functions.dart';
// import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/view/helper/today_report_view.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class InsertTodolist extends StatefulWidget {
  final DatabaseHandle db;
  const InsertTodolist({super.key, required this.db});

  @override
  State<InsertTodolist> createState() => _InsertTodolistState();
}

class _InsertTodolistState extends State<InsertTodolist> {
  // Property
  late TextEditingController titleController;
  late TextEditingController contentController;
  int dropDownValue = 5;
  bool isAlarm = false;
  DateTime? startDate;
  // late DatabaseHandle db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    // db = DatabaseHandle();
  }

  @override
  void dispose() {
    // Controller dispose
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('추가 하기')),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 500,
              height: 50,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: TodayReportView(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      Text('중요도'),
                      DropdownButton(
                        dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        value: dropDownValue,
                        icon: Icon(Icons.arrow_drop_down),

                        items: List.generate(10, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text((index + 1).toString(), style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                          );
                        }),
                        onChanged: (value) {
                          dropDownValue = value!;
                          setState(() {});
                        },
                      ),
                      Text('알람'),
                      Switch(
                        value: isAlarm,
                        onChanged: (value) {
                          isAlarm = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "할일을 입력하세요.",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "메모를 입력하세요.",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => showCalendar(),

                        child: Column(children: [Icon(Icons.calendar_month, size: 30), Text('설정')]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('일정날짜/시간'),
                          Text(
                            startDate != null ? '현재설정: ${startDate}' : '날짜/시간을 설정하세요(설정 아이콘)',
                            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => beforeAction(),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: Text('저장'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==== Functions
  // 저장하기전에 validation
  beforeAction() async {
    if (titleController.text.trim().isNotEmpty && startDate != null) {
      // Success

      TodoList todolist = TodoList(
        title: titleController.text.trim(),
        startDate: startDate,
        content: contentController.text.trim(),
        importance: dropDownValue,
        isAlarm: isAlarm ? 1 : 0,
      );

      Get.defaultDialog(
        title: '설정내용확인',
        content: Container(
          width: 100,
          height: 200,
          child: Column(
            children: [
              Text('일정제목: ${todolist.title}'),
              Text('메모: ${todolist.content}'),
              Text('중요도: ${todolist.importance}'),
              Text('알람: ${todolist.isAlarm}'),
              Text('날짜: ${todolist.startDate}'),
            ],
          ),
        ),
        confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => insertAction(todolist),
          child: Text('저장'),
        ),
        cancel: ElevatedButton(onPressed: () => Get.back(), child: Text('취소')),
      );

      print('${todolist.title} - ${todolist.startDate} - ${todolist.importance} - ${todolist.isAlarm}');
      // await db.insertTodoList(todolist, TableName.todolist)
    } else {
      // Empty
      // snackbar
      // Get.snackbar('알림', '타이틀 또는 날짜/시간을 입력해 주세요');
      CommonFunctions.showMessage(-110, '타이틀 또는 날짜/시간');
    }
  }

  // 저장하는 펑션
  insertAction(TodoList todolist) async {
    int result = await widget.db.insertTodoList(todolist, TableName.todolist);
    if (result == 0) {
      // Get.snackbar(
      //   '에러',
      //   '저장에 실패 했습니다. 다시 시도해 보세요.',
      //   backgroundColor: Theme.of(context).colorScheme.errorContainer,
      // );
      CommonFunctions.showMessage(result, '저장');

      Get.back();
    } else {
      // DateTime today = DateTime.now();
      //  if (todolist.startDate!.year == today.year &&
      //     todolist.startDate!.month == today.month &&
      //     todolist.startDate!.day == today.day) {
      //       if(todolist.isAlarm==1) TodayReport.alarmCount++;
      //       if(todolist.importance!>5) TodayReport.importantCount++;
      //       TodayReport.count++;
      //   }
      Get.back();
      Get.back();
      // Get.snackbar('알림', '정상적으로 저장 됬습니다.');
      CommonFunctions.showMessage(1, '저장');
    }
  }

  // 캘린더/시간 설정을 위한 부분
  showCalendar() async {
    DateTime? pickedDate =
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(), // 최초 선택된 날짜
          firstDate: DateTime(2025),
          lastDate: DateTime(2090),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          // locale: Locale('ko','KR'), // 항상 한국어로 표현
          // 영문 사용자는 영어로 되게 supportedLocales 로 설정해야 함.
        ).then((DateTime? value) async {
          if (value != null) {
            final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 22, minute: 10));

            startDate = DateTime(
              value.year,
              value.month,
              value.day,
              pickedTime != null ? pickedTime!.hour : 0,
              pickedTime != null ? pickedTime.minute : 0,
            );
          }
          setState(() {});
        });
  }
}
