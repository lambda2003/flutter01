import 'dart:async';
import 'dart:math';
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
  // int _nextImage = 1;
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
    // Timer.periodic(Duration(seconds: 3), (timer)=>run());
  }

  @override
  Widget build(BuildContext context) {
    // 현재 스크린 사이즈 가져오기
    Size screenSize = MediaQuery.of(context).size;
    // print('${screenSize.width},${screenSize.height}');
    // 반응형 기준값(이미지 비율 : 400*600 -> 2:3)
    final double maxBaseWidth = (screenSize.width~/100) * 100; //400; // 최대폭
  
    final double baseWidth = min(screenSize.width * 0.9, maxBaseWidth);
    final double baseHeight = screenSize.width * 1.5;

    // 테두리 패딩
    double bigBorder = 5; // 큰이미지 보더
    double smallBorder = 2; // 작은 이미지 보더
    double inset = 8;

    // 작은 이미지 크기
    double smallW = baseWidth * 0.25;
    double smallH = smallW * 1.5; // 2:3비율

    return Scaffold(
      appBar: AppBar(title: Text('무한이미지반복'), toolbarHeight: 70),
      body: SimpleGestureDetector(
        onHorizontalSwipe: (direction) => _onHorizontalSwipe(direction),

        // onVerticalSwipe: (direction) => _onVerticalSwipe(direction),
        // onDoubleTap: () => stop(),// _onHorizontalSwipe(null),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_imageNames[_currentImage]),
              SizedBox(
                width: baseWidth + bigBorder * 2,
                height: baseHeight + bigBorder * 2,

                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: bigBorder,
                        ),
                      ),

                      child: Image.asset(
                        'images/${_imageNames[_currentImage]}',
                        width: baseWidth,
                        height: baseHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Image.asset('images/${_imageNames[_nextImage]}',width:100),
                    Positioned(
                      right: bigBorder + inset,
                      bottom: bigBorder + inset,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: smallBorder,
                          ),
                        ),
                        child: _currentImage + 1 == _imageNames.length
                            ? Image.asset(
                                'images/${_imageNames[0]}',
                                width: smallW,
                                height: smallH,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'images/${_imageNames[_currentImage + 1]}',
                                width: smallW,
                                height: smallH,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),

                    // _currentImage+1==_imageNames.length ?
                    //  Image.asset('images/${_imageNames[0]}', width: 100,fit: BoxFit.fill,)
                    // :Image.asset('images/${_imageNames[_currentImage+1]}',width:100),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: ()=>prevButton(), 
                    child: Icon(Icons.navigate_before)
                  ),
                  ElevatedButton(
                    onPressed: ()=>nextButton(), 
                    child: Icon(Icons.navigate_next)
                  ),
                ],
              )

              // Container(
              //   height: 500,
              //   width: 300,

              //   // child: Image.asset('images/${_imageNames[_currentImage]}',width:300, fit: BoxFit.fill,), //Text('aa'),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: DecorationImage(
              //       fit: BoxFit.fill,
              //       image: AssetImage('images/${_imageNames[_currentImage]}'),
              //     ),
              //   ),
              //   child: SizedBox(
              //     width: 400,
              //     height: 300,

              //     child: _currentImage+1==_imageNames.length ?
              //     Image.asset('images/${_imageNames[0]}', width: 50)
              //     :Image.asset('images/${_imageNames[_currentImage+1]}',width:50),

              //   ),

              // ),
            ],
          ),
        ),
      ),
    );
  }

  prevButton(){
    if(_currentImage<=0){
      _currentImage = _imageNames.length-1;
    }else{
      _currentImage--;
    }
     setState(() {
      
      });
  }
  nextButton(){
    if(_currentImage >= _imageNames.length-1){
      _currentImage = 0;
     
    }else {
      _currentImage++;
    }
     setState(() {
      
      });
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
    setState(() {});
  }

  run() {
    if (isStarted) {
      _currentImage++;
      if (_currentImage > _imageNames.length - 1) {
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
