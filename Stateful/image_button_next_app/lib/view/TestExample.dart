import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TestExample extends StatefulWidget {
  const TestExample({super.key});

  @override
  State<TestExample> createState() => _TestExampleState();
}

class _TestExampleState extends State<TestExample> {
  late List<List<String>> _imageNames;
  int _currentImage = 0;
  bool isStarted = true;
  
  // Timer 설치



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageNames = [[
      'flower_01.png', // 0
      'flower_02.png', // 1
      'flower_03.png'],[ // 2
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
      ]
    ];
    Timer.periodic(Duration(seconds: 3), (timer)=>run());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SimpleGestureDetector(
        onHorizontalSwipe: (direction) => _onHorizontalSwipe(direction),
        // onVerticalSwipe: (direction) => _onVerticalSwipe(direction),
        onDoubleTap: () => stop(),// _onHorizontalSwipe(null),
        
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
             primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
                Image.asset('images/${_imageNames[_currentImage][0]}',width:150),
                Image.asset('images/${_imageNames[_currentImage][1]}',width:150),
                Image.asset('images/${_imageNames[_currentImage][2]}',width:150),
            ]
          ),
          
        ),
      ),
    );
  }

  // ======== Functions
  _onHorizontalSwipe(SwipeDirection? direction) {
    // 왼쪽으로 움직임
 
    if (direction == SwipeDirection.left || direction == null) {
      _currentImage++;
      if (_currentImage >= _imageNames.length) {
        _currentImage = 0;
      }
    } else {
      _currentImage--;
      if (_currentImage < 0) {
        _currentImage = _imageNames.length - 1;
      }
    }
    setState(() {});
  }

  _onVerticalSwipe(SwipeDirection direction) {
    // 탑다운
    if (direction == SwipeDirection.up) {
      _currentImage++;
      if (_currentImage >= _imageNames.length) {
        _currentImage = 0;
      }
    } else {
      _currentImage--;
      if (_currentImage < 0) {
        _currentImage = _imageNames.length - 1;
      }
    }
    setState(() {});
  }
  
  stop() {
    isStarted = !isStarted;
    setState(() {
      
    });
  }

  run() {
    if(isStarted){
      _currentImage++;
      if(_currentImage> _imageNames.length-1){
        _currentImage = 0;
      }
      setState(() {});
    }
  }

  // run() async {
  //   int index  = 0;

  //   while(true){
  //     if(_currentImage >= _imageNames.length
  //     if(index> 6) break;

  //     await Future.delayed(Duration(seconds: 3));
  //     _currentImage++;
  //     print(_currentImage);
  //     setState(() {
        
  //     });
  //     index++;
  //   }
  // }

}
