import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/today_report.dart';
import 'package:simple_todo_list_app/view/today_report_view.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class UpdateTodolist extends StatefulWidget {
  const UpdateTodolist({super.key});

  @override
  State<UpdateTodolist> createState() => _UpdateTodolistState();
}

class _UpdateTodolistState extends State<UpdateTodolist> {
  // Property
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int dropDownValue;
  late bool isAlarm;
  late DateTime? startDate;

  TodoList? todo = Get.arguments;

  late DatabaseHandle db;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    db = DatabaseHandle();

    // 로컬 초기 셋팅값
    titleController.text = todo!.title;
    dropDownValue = todo!.importance!;
    isAlarm = todo!.isAlarm == 0 ? false : true;
    startDate = todo!.startDate;
    contentController.text = todo!.content != null ? todo!.content! : '';
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
      appBar: AppBar(title: Text('변경: ${todo!.title} ')),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 400,
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
                        dropdownColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        value: dropDownValue,
                        icon: Icon(Icons.arrow_drop_down),

                        items: List.generate(10, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "메모를 입력하세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => showCalendar(),

                        child: Column(
                          children: [
                            Icon(Icons.calendar_month, size: 30),
                            Text('설정'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('일정날짜/시간'),
                          Text(
                            startDate != null
                                ? '현재설정: ${startDate}'
                                : '날짜/시간을 설정하세요(설정 아이콘)',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => checkAction(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
  checkAction() async {
    if (titleController.text.trim().isNotEmpty) {
      // Success

      // TodoList todolist = TodoList(
      //   title: titleController.text.trim(),
      //   startDate: startDate,
      //   importance: dropDownValue,
      //   isAlarm: isAlarm?1:0,
      // );

      TodoList todolist = TodoList(
        id: todo!.id,
        title: titleController.text.trim(),
        startDate: startDate,
        importance: dropDownValue,
        isAlarm: isAlarm ? 1 : 0,
      );

      // todo!.title = titleController.text.trim();
      // todo!.startDate = startDate;
      // todo!.importance = dropDownValue;
      // todo!.isAlarm = isAlarm ? 1 : 0;

      Get.defaultDialog(
        title: '설정내용확인',
        content: Container(
          width: 100,
          height: 200,
          child: Column(
            children: [
              Text('일정제목: ${todolist.title}'),
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
          onPressed: () => updateAction(todolist),
          child: Text('저장'),
        ),
        cancel: ElevatedButton(onPressed: () => Get.back(), child: Text('취소')),
      );

      print(
        '${todolist.title} - ${todolist.startDate} - ${todolist.importance} - ${todolist.isAlarm}',
      );
    } else {
      // Empty
      showMessage(-110, '타이틀');
    }
  }

  updateAction(TodoList todolist) async {
    int result = await db.updateTodoList(todolist, TableName.todolist);
    if (result == 0) {
      // Get.snackbar(
      //   '에러',
      //   '업데이트에 실패 했습니다. 다시 시도해 보세요.',
      //   backgroundColor: Theme.of(context).colorScheme.errorContainer,
      // );

      Get.back();
    } else {
      // DateTime today = DateTime.now();
      // print('${todolist.startDate!.year} = ${today.year} , ${todolist.startDate!.month} = ${today.month} , ${todolist.startDate!.day} = ${today.day}');
      //  if (todolist.startDate!.year == today.year &&
      //     todolist.startDate!.month == today.month &&
      //     todolist.startDate!.day == today.day) {

      //   if (todo!.isAlarm == 0 && todolist.isAlarm == 1) {
      //     TodayReport.alarmCount++;
      //   } else if (todo!.isAlarm == 1 && todolist.isAlarm == 0) {
      //     TodayReport.alarmCount--;
      //   }

      //   if (todo!.importance! < 6 && todolist.importance! > 5) {
      //     TodayReport.importantCount++;
      //   }else if (todo!.importance! > 5 && todolist.importance! < 6) {
      //     TodayReport.importantCount--;
      //   }

      // }else{
      //   // TodayReport.count--;

      //   TodayReport.alarmCount--;
      //   TodayReport.importantCount--;
      // }

      // print('ImportCount =====> ${TodayReport.importantCount}');
      Get.back();
      Get.back();
      // Get.snackbar('알림', '정상적으로 업데이트 됬습니다.');
    }
    showMessage(result, '업데이트');
  }

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
            int hour = 11;
            int min = 0;
            if (todo!.startDate != null) {
              hour = todo!.startDate!.hour;
              min = todo!.startDate!.minute;
            }

            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: hour, minute: min),
            );
            if (pickedTime != null) {
              startDate = DateTime(
                value.year,
                value.month,
                value.day,
                // pickedTime != null ? pickedTime.hour : 0,
                // pickedTime != null ? pickedTime.minute : 0,
                pickedTime.hour,
                pickedTime.minute,
              );
              setState(() {});
            }
          }
          // setState(() {});
        });
  }

  showMessage(int i, String msg) {
    if (i == 0) {
      Get.snackbar('에러', '$msg에 에러가 발생했습니다.', backgroundColor: Colors.red);
    } else {
      if (i == -110) {
        // 알람 관련에러 toggleAlarm validation fail
        Get.snackbar(
          '알림',
          '$msg일 불가합니다. 날짜를 변경하세요.',
          backgroundColor: Colors.orange[500],
        );
      } else if (i == -120) {
        // 입력관련에러
        // 날짜변경 validation fail
        Get.snackbar(
          '알림',
          '$msg을 입력해 주세요.',
          backgroundColor: Colors.orange[500],
        );
      } else {
        Get.snackbar('알림', '$msg에 성공했습니다.', backgroundColor: Colors.green[500]);
      }
    }
  }
}
