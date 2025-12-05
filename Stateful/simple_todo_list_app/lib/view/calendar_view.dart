import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:simple_todo_list_app/util/calendar_data.dart';
import 'package:simple_todo_list_app/view/today_report_view.dart';
import 'package:simple_todo_list_app/vm/database_handle.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final DatabaseHandle db;
  const CalendarView({super.key,required this.db});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<TodoList>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// final _kEventSource = {
//   for (var item in List.generate(50, (index) => index))
//     DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
//       item % 4 + 1,
//       (index) => TodoList(title:'Event $item | ${index + 1}'),
//     ),
// }..addAll({
//     kToday: [
//       TodoList(title:"Today's Event 1"),
//       TodoList(title:"Today's Event 2"),
//     ],
//   });

class _CalendarViewState extends State<CalendarView> {
  // isLoading이 현재 필요 없다.
  // builder를 실행하기전에 데이터받기가 완료됬으므로 화면에 로딩 표시가 안나옴. 
  bool isLoading = true;
  final DateTime gtToday = DateTime.now();
  late DateTime gtStartDay = DateTime(
    gtToday.year,
    gtToday.month - 3,
    gtToday.day,
  );
  late DateTime gtEndDay = DateTime(
    gtToday.year,
    gtToday.month + 3,
    gtToday.day,
  );

  late ValueNotifier<List<TodoList>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  // .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  late DateTime? _selectedDay;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

  // late DatabaseHandle db;
  late LinkedHashMap<DateTime, List<TodoList>> kEvents =
      LinkedHashMap<DateTime, List<TodoList>>();

  @override
  void initState() {
    super.initState();
    // db = DatabaseHandle();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    initData();
  }

  initData() async {

    List<TodoList> todolist = await widget.db.getTodoList(
      {
        'range': {
          'startDate': DateTime(
            gtStartDay.year,
            gtStartDay.month,
            1,
          ).toString(),
          'endDate': DateTime(gtEndDay.year, gtEndDay.month, 1).toString(),
        },
      },
      TableName.todolist,
      0,
    );
    
    // Todo: Maybe possible to make data.map??
    // Todo: ... 오늘것을 처음에 못보여줌. 
    LinkedHashMap<DateTime, List<TodoList>> d =
        LinkedHashMap<DateTime, List<TodoList>>();
    for (var item in todolist) {
      if (!d.containsKey(
        DateTime(
          item.startDate!.year,
          item.startDate!.month,
          item.startDate!.day,
        ),
      )) {
        d[DateTime(
              item.startDate!.year,
              item.startDate!.month,
              item.startDate!.day,
            )] =
            [];
      }
      d[DateTime(
            item.startDate!.year,
            item.startDate!.month,
            item.startDate!.day,
          )]!
          .add(item);
    }
   
    kEvents = LinkedHashMap<DateTime, List<TodoList>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(d);
    isLoading = false;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    setState(() {});
    
  }

  @override
  void dispose() {
    
    _selectedEvents.dispose();
    super.dispose();
  }

  List<TodoList> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  // List<TodoList> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = null;
  //     _focusedDay = focusedDay;
  //     _rangeStart = start;
  //     _rangeEnd = end;
  //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
  //   });

  //   // `start` or `end` could be null
  //   if (start != null && end != null) {
  //     _selectedEvents.value = _getEventsForRange(start, end);
  //   } else if (start != null) {
  //     _selectedEvents.value = _getEventsForDay(start);
  //   } else if (end != null) {
  //     _selectedEvents.value = _getEventsForDay(end);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      
      
      
      
       isLoading ? 
        Center(child: const CircularProgressIndicator()) 
      : Column(
        children: [
          Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 500,
              height: 50,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: TodayReportView(),
            ),
          TableCalendar<TodoList>(
            locale: 'ko_KR',
            firstDay: gtStartDay,
            lastDay: gtEndDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            // rangeStartDay: _rangeStart,
            // rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            // rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            rowHeight: 60.0,
            
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
              // holidayDecoration: BoxDecoration(
              //   color:  CalendarData.colors['holidayDecorationColor'],
              //   // borderRadius: BorderRadius.circular(5),

              //   // border: Border.all()
              // ),
              // weekNumberTextStyle:TextStyle(color: Colors.red),


              
              weekendTextStyle: TextStyle(color: CalendarData.colors['weekendText']),
              defaultTextStyle: TextStyle(color: CalendarData.colors['defaultText']),
             
             
             
             
              // selectedDecoration: BoxDecoration(
              //   shape: BoxShape.rectangle,
              //   color: Colors.green,
              //   borderRadius: BorderRadius.circular(10)
              // ),
              // todayDecoration: BoxDecoration(
              //   shape: BoxShape.rectangle,
              //   color: Colors.blue[400],
              //   borderRadius: BorderRadius.circular(10)
              // ),

              // weekendDecoration: BoxDecoration(
              //    color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(5),
              // ),
            ),
            
            daysOfWeekHeight: 30.0,
            
            // daysOfWeekStyle: DaysOfWeekStyle(
              
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //   ),
            // ),
            holidayPredicate: (day) => CalendarData.holidayList.any((holiday) => isSameDay(day, holiday)),
            onDaySelected: _onDaySelected,
            // onRangeSelected: _onRangeSelected,

            // --- Use calendarBuilders to customize UI ---
        calendarBuilders: CalendarBuilders(
          // Custom builder for the default appearance of days
          defaultBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(color: Colors.black54),
              ),
            );
          },
          // Custom builder for the selected day
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          // Custom builder for "Today"
          todayBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          holidayBuilder: (context, day, focusedDay) {
            return Center(
              child: 
              // Text(
              //   '${day.day}',
              //   style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
              // ),
              TextButton(
                child: Text('${day.day}',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                onPressed: (){
                  Get.snackbar('휴일', '법정휴일입니다.');
                },
              ),
            );
          },
          // Custom builder for event markers below the day number
          markerBuilder: (context, day, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 5.0,
                child: Container(
                  width: 5.0,
                  height: 5.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              );
          
        
              
            }
            return null; // Return null if no marker is needed
          },
        ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<TodoList>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index].title}'),
                        title: value[index].importance! > 5
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${value[index].title}',),
                                    Icon(
                                      Icons.priority_high_outlined,
                                      color: Colors.red[500],
                                    ),
                                  ],
                                ),
                            )
                            : Text('${value[index].title}'),

                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '약속시간: ${value[index].startDate!.hour}시 ${value[index].startDate!.minute}분',
                              ),
                              Text(' - ${value[index].content}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
