import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/view/deleted_list.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';
import 'package:sqflite/sqlite_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  DatabaseHandle? db;
  late TextEditingController titleController;
  late DateTime? startDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
    titleController = TextEditingController();
    startDate = null;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO LIST'),
        actions: [
          IconButton(
            onPressed: () => Get.to(DeletedList()),
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () => actionDialog('insert', null),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: db!.getTodoList(null, 'todolist'),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data != null
                        ? snapshot.data!.length
                        : 0,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) =>
                                  deleteAction(snapshot.data![index].id!),

                              backgroundColor: Colors.red,
                              icon: Icons.delete_outline,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              actionDialog('update', snapshot.data![index]),
                          child: SizedBox(
                            width: 400,
                            height: 80,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                 
                                     Icon(Icons.calendar_month),
                                    Text(
                                      'Title : ${snapshot.data![index].title}'
                                    ),
                                     Text(
                                      'Date : ${snapshot.data![index].startDate!.substring(0,16)}'
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Text('bb'),
          ],
        ),
      ),
    );
  }

  // == Functions
  deleteAction(int id) async {
    final int result = await db!.deleteTodoList(id);
    Get.to(DeletedList())!.then((value) => setState(() {}));
  }

  actionDialog(String isType, TodoList? todolist) async {
    if (isType == 'insert') {
      titleController.text = '';
          startDate = null;
    } else {
      titleController.text = todolist != null ? todolist.title : '';
          startDate =  DateTime.parse(todolist!.startDate!);
    }



    Get.dialog(
      AlertDialog(
        title: Text(isType == 'insert' ? 'Todo List 추가' : 'Todo list 변경'),
        content: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "todolist를 입력하세요."),
              ),
              TextButton(
                onPressed: ()=>showCalendar(),
                child: Row(children: [
                  Text('StartDate:'),
                  Icon(Icons.calendar_month),
                   
                ],)  
              ),
             
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               
              TextButton(
                onPressed: () async {
                  //

                  if (isType == 'insert') {
                    final tmpTodolist = TodoList(
                      title: titleController.text.trim(),
                      startDate: startDate == null? DateTime.now().toString(): startDate.toString(),
                    );

                    int result = await db!.insertTodoList(tmpTodolist,'todolist');
                    resultHandle(isType,result);
                    // if (result != 0) {
                    //   Get.back();
                    //   setState(() {
                    //     titleController.text = '';
                    //   });
                    // } else {
                    //   resultHandle(isType,result);
                    // }
                  } else {
                    // final tmpTodolist = TodoList(
                    //   id: todolist!.id,
                    //   title: titleController.text.trim(),
                    //   startDate: DateTime.now().toString(),
                    // );
                    // if(todolist!.title == titleController.text.trim()){
                    //   resultHandle(isType,-1);
                    // }else{}
                      todolist!.title = titleController.text.trim();
                      todolist!.startDate = startDate == null? DateTime.now().toString(): startDate.toString();
                      int result = await db!.updateTodoList(todolist,'todolist');
                      resultHandle(isType,result);
                      // if (result != 0) {
                      //   Get.back();
                      //   setState(() {});
                      //   // reload();
                      // } else {
                      //   // Show snackbar
                      //  errorMessageHandle(isType,result);
                      // }
                    
                  }
                },
                child: Text('저장'),
              ),
              TextButton(onPressed: () => Get.back(), child: Text('취소')),
            ],
          ),
        ],
      ),
    );
  }


  resultHandle(String isType,int result){
    if(result == 0) {
      Get.snackbar(isType!='insert'? '업데이트 하는 동안 에러가 발생했습니다.':'추가하는 동안 에러가 발생했습니다.', '다시 시도해 보세요.');
    }else if(result == -1) {
     
      Get.back();
      Get.snackbar('알림: ', isType!='insert'? '업데이트 성공(${result}).':'추가 성공', backgroundColor: Colors.deepPurple[100]);
     
    }else { 
      Get.back();
      Get.snackbar('알림: ', isType!='insert'? '업데이트 성공.(${result})':'추가 성공(${result})', backgroundColor: Colors.deepPurple[100]);
      setState(() {});
    }
  } 
  
  showCalendar() async {
  
      DateTime? pickedDate  = await showDatePicker(
        context: context,
        initialDate: startDate==null?DateTime.now():startDate,    // 최초 선택된 날짜
        firstDate: DateTime(2025),
        lastDate: DateTime(2090),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        // locale: Locale('ko','KR'), // 항상 한국어로 표현
        // 영문 사용자는 영어로 되게 supportedLocales 로 설정해야 함. 
      ).then((DateTime? value) async {
        if(value != null){
           final pickedTime= await showTimePicker(
          context: context,
          initialTime: startDate != null?  TimeOfDay(hour: startDate!.hour, minute: startDate!.minute) :TimeOfDay(hour: 22, minute: 10),
          
        );
          startDate =  DateTime(
            value.year,
            value.month,
            value.day,
            pickedTime!.hour,
            pickedTime.minute,
          );
        }

      });

      
       
      
   
      


  }


  // // Reload
  // reload() async {
  //   final result = await db!.getTodoList();
  //   print("result ========= ${result}");
  //   setState(() {});
  // }

  // // update
  // updateTodoList(TodoList todolist) async{
  //   int result = await db!.updateTodoList(todolist);
  //   print('===== ${result}');
  //   if(result != 0){
  //     // Success
  //   }else{
  //     // Fail
  //   }

  // }
}
