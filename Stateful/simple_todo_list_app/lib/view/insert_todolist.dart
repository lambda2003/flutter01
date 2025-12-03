import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';

class InsertTodolist extends StatefulWidget {
  const InsertTodolist({super.key});

  @override
  State<InsertTodolist> createState() => _InsertTodolistState();
}

class _InsertTodolistState extends State<InsertTodolist> {
  // Property
  late TextEditingController titleController;
  int dropDownValue = 5;
  bool isAlram = false;
  DateTime? startDate;
  late DatabaseHandle db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    db = DatabaseHandle();
  }

  @override
  void dispose() {
    titleController.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert TodoList')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "todolist를 입력하세요."),
              ),
              Row(
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
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                    value: isAlram, onChanged: (value){
                      isAlram = value;
                      setState(() {
                        
                      });
                    }),
                ],
              ),
           
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   TextButton(
                onPressed: () => showCalendar(),
               
                child: Column(children: [
                   Icon(Icons.calendar_month,size:30),
                   Text('설정'),
                ],)
              ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('일정날짜/시간'), 
                     Text(startDate!=null?startDate.toString():'날짜/시간을 설정하세요',style: TextStyle(
                      fontSize: 13, color:Colors.grey[500]
                     ),)
                    ],
                  )
                   
                ],
              ),

              ElevatedButton(
                onPressed: ()=>checkAction(),
               child: Text('저장'))
              
            ],
          ),
        ),
      ),
    );
  }

  // ==== Functions
  checkAction() async {
    if(titleController.text.trim().isNotEmpty){
      // Success




      TodoList todolist = TodoList(
        title: titleController.text.trim(),
        startDate: startDate,
        importance: dropDownValue,
        isAlram: isAlram?1:0,
      );

      Get.defaultDialog(
        title: '설정내용확인',
        content: Container(
          width: 100,
          height: 200,
          child: Column(
            children: [
              Text('일정제목: ${todolist.title}'),
              Text('중요도: ${todolist.importance}'),
              Text('알람: ${todolist.isAlram}'),
              Text('날짜: ${todolist.startDate}'),
            ],
          ),
          
        ),
         confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimary
          ),
          onPressed: ()=>insertAction(todolist), child: Text('저장')),
        cancel: ElevatedButton(onPressed: ()=>Get.back(), child: Text('취소')),
       
      );

      print('${todolist.title} - ${todolist.startDate} - ${todolist.importance} - ${todolist.isAlram}');
      // await db.insertTodoList(todolist, TableName.todolist)
    }else{
      // Empty
      // snackbar
    }
    
  }

  insertAction(TodoList todolist) async {
    int result = await db.insertTodoList(todolist, TableName.todolist);
    if(result == 0){
      Get.snackbar('에러', '저장에 실패 했습니다. 다시 시도해 보세요.', backgroundColor: Theme.of(context).colorScheme.errorContainer);
       Get.back();
    }else{
      Get.back();
      Get.back();
      Get.snackbar('알림', '정상적으로 저장 됬습니다.');
      
    } 
   
  }

  showCalendar() async {
  
      DateTime? pickedDate  = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),    // 최초 선택된 날짜
        firstDate: DateTime(2025),
        lastDate: DateTime(2090),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        // locale: Locale('ko','KR'), // 항상 한국어로 표현
        // 영문 사용자는 영어로 되게 supportedLocales 로 설정해야 함. 
      ).then((DateTime? value) async {
        if(value != null){
           final pickedTime= await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 22, minute: 10),
          
        );
        startDate =  DateTime(
            value.year,
            value.month,
            value.day,
            pickedTime!.hour,
            pickedTime.minute,
          );
        }
        setState(() {
          
        });
      });
  }


}
