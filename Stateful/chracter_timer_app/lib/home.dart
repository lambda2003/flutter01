import 'dart:async';



import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  final String _data = "대한민국";
  late List<String> _dataList;
  int _count = 0;
  late List<Widget> display;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for(int i=0;i<_data.length;i++){
    //   _dataList.add(_data[i]);
    // }
    _dataList = _data.split("");
    display = [];
    // display.add(Text(_dataList[0]));
    Timer.periodic(Duration(milliseconds: 100), (timer)=>start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: display,
      )
    )
    );
  }

  // === Function 
  start() {
    if(_count>=_dataList.length){
      display = [];
      _count =0;
    }else{
      display.add(Text(_dataList[_count],style: TextStyle(
        fontSize: 30+(_count*8),
      )));
      _count++;
    }
    setState(() {
      
    });
    
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

}