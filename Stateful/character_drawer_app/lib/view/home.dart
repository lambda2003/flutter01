import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late TextEditingController _tc1;
  late String _data;
  late List<String> _dataList;
  int _count = 0;
  late List<Widget> display;
  late Timer t;
  double _slider_value = 5000.0;
  late bool _isPause;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tc1 = TextEditingController();
    _data = '';
    _dataList = [];
    display = [];
    _isPause = false;
    // display.add(Text(_dataList[0]));
    // t = Timer(Duration(milliseconds: 500),()=>start());

    t = Timer.periodic(
      Duration(milliseconds: _slider_value.toInt()),
      (timer) => start(),
    );
    t.cancel();

    // Timer.periodic(Duration(milliseconds: 100), (timer)=>start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED 광고'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: Drawer(
        // backgroundColor: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            DrawerHeader(
              child: SizedBox(
                width: 500,
                height: 200,
                child: Center(
                  child: Text(
                    '광고문구를 넣어주세요.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _tc1,
                decoration: InputDecoration(
                  labelText: "광고문구를 넣어주세요",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Slider(
                  value: _slider_value,
                  divisions: 20,
                  min: 100,
                  max: 5000,
                  label: '${_slider_value.toStringAsFixed(2)} sec',
                  onChanged: (value) => changeSlideValue(value),
                ),

                Text('${_slider_value.toStringAsFixed(2)} sec'),
              ],
            ),

            ElevatedButton(
              onPressed: () => buttonSubmit(),
              child: Text('문구생성'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Example: ${_data}'),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: display,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _isPause = !_isPause;
                if (_isPause)
                  t.cancel();
                else
                  t = Timer.periodic(
                    Duration(milliseconds: _slider_value.toInt()),
                    (timer) => start(),
                  );
                setState(() {});
              },
              child: Text(_isPause?'Start':'Pause'),
            ),
          ],
        ),
      ),
    );
  }

  // === Function
  buttonSubmit() {
    if (t != null) t.cancel();
    if (!_tc1.text.isEmpty) {
      print('======= ${_slider_value.toString()}');
      t = Timer.periodic(
        Duration(milliseconds: _slider_value.toInt()),
        (timer) => start(),
      );

      Navigator.of(context).pop();
      _dataList = [];
      _data = _tc1.text.trim();
      _dataList = _data.split("");
      setState(() {});
    }
  }

  changeSlideValue(value) {
    _slider_value = value;
    if (t != null) t.cancel();
    if (_dataList.length > 0) {
      t = Timer.periodic(
        Duration(milliseconds: _slider_value.toInt()),
        (timer) => start(),
      );
    }
    setState(() {});
  }

  start() {
    if (_dataList.length > 0) {
      print('1======${t.hashCode}');

      if (_count >= _dataList.length) {
        display = [];
        _count = 0;
      } else {
        display.add(
          // RotatedBox(quarterTurns: _count, child:  Text(
          //   _dataList[_count],
          //   style: TextStyle(fontSize: 20.0 + _count*5+pow(_count*1.3,2)),
          // ),)
          // Text(
          //   _dataList[_count],
          //   style: TextStyle(fontSize: 30 + (_count * 8)),
          // ),
          Text(
            _dataList[_count],
            style: TextStyle(
              fontSize: 20.0 + _count * 5 + pow(_count * 1.3, 2),
              color: Color.fromARGB(100 - _count * 15, 0, 0, 0),
            ),
          ),
        );
        _count++;
      }
      setState(() {});
    }
    //  if(_count>=_dataList.length){
    //   display = [];
    //   _count--;
    // }else if(_count<=0){
    //         display.add(Text(_dataList[_count],style: TextStyle(
    //     fontSize: 30+(_count*8),
    //   )));
    //   _count++;
    // }else{
    //   display.add(Text(_dataList[_count],style: TextStyle(
    //     fontSize: 30+(_count*8),
    //   )));
    //   _count++;
    // }
    // setState(() {

    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    t.cancel(); // Make sure
    super.dispose();
  }
}
