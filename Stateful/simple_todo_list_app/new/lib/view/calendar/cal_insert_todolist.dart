import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/common_functions.dart';
// import 'package:simple_todo_list_app/util/today_report.dart';
// import 'package:simple_todo_list_app/view/helper/today_report_view.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class CalInsertTodolist extends StatefulWidget {
  final DatabaseHandle db;
  final DateTime day;
  const CalInsertTodolist({super.key, required this.db, required this.day});

  @override
  State<CalInsertTodolist> createState() => _CalInsertTodolistState();
}

class _CalInsertTodolistState extends State<CalInsertTodolist> {
  // Property
  late TextEditingController titleController;
  late TextEditingController contentController;
  int dropDownValue = 5;
  bool isAlarm = false;

  Duration duration = const Duration(hours: 1, minutes: 23);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
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
    return Container(
      height: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('일정추가', style: TextStyle(fontSize: 20)),
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
                    labelText: "메모(장소)를 입력하세요.",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                ),

                SizedBox(
                  height: 100,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm, //hm,
                    initialTimerDuration: duration,

                    // 변경될때 call함수
                    onTimerDurationChanged: (Duration newDuration) {
                      setState(() => duration = newDuration);
                    },
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,

                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => beforeAction(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('저장'),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: Text('취소'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==== Functions
  // 저장하기전에 validation
  beforeAction() async {
    if (titleController.text.trim().isNotEmpty) {
      // Success
      int totalMins = duration.inMinutes;
      int hours = totalMins ~/ 60;
      int mins = totalMins % 60;

      TodoList todolist = TodoList(
        title: titleController.text.trim(),
        startDate: DateTime(widget.day.year, widget.day.month, widget.day.day, hours, mins),
        content: contentController.text.trim(),
        importance: dropDownValue,
        isAlarm: isAlarm ? 1 : 0,
      );

      await insertAction(todolist);
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

    Get.back(result: [result, todolist]);
  }
}
