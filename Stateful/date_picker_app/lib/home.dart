import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late DateTime date;
  late String selectDateText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateTime.now();
    selectDateText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 일자는 ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 입니다.',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => displayDatePicker(),
                child: Text('Data Picker'),
              ),
            ),
            Text(selectDateText),
          ],
        ),
      ),
    );
  }

  displayDatePicker() async {
    // 날짜 점위
    int firstYear = date.year-1;
    int lastYear = date.year+5;
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: date,    // 최초 선택된 날짜
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      
      // locale을 여기서 설정하면 항상 한국어로 나옴.
      // supportedLocales: [Locale('ko','KR'),Locale('en','US')]
      // 에 넣어주어야 시스템 환경에 따른 랭귀지로 보여줌. 
      // locale: Locale('ko','KR'),

    );
    
    if (result != null) {
      selectDateText =
          '선택한 일자는 ${result.toString().substring(0,10)} 입니다..';
      setState(() {});
    }
  }
}
