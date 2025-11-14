import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<String> _imageNames;
  int _currentImage = 0;
  bool isStarted = true;
  
  // Timer 설치



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageNames = [
      'flower_01.png', // 0
      'flower_02.png', // 1
      'flower_03.png', // 2
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];
    Timer.periodic(Duration(seconds: 3), (timer)=>run());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SimpleGestureDetector(
        onHorizontalSwipe: (direction) => _onHorizontalSwipe(direction),
        onVerticalSwipe: (direction) => _onVerticalSwipe(direction),
        onDoubleTap: () => stop(),// _onHorizontalSwipe(null),
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(_imageNames[_currentImage]),
              Container(
                height: 500,
                width: 300,

                // child: Image.asset('images/${_imageNames[_currentImage]}',width:300, fit: BoxFit.fill,), //Text('aa'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/${_imageNames[_currentImage]}'),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text(
                    '${_imageNames[_currentImage]}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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
