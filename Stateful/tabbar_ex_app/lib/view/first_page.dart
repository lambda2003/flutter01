import 'dart:async';

import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Property
  bool _isStart = false;
  double _degree = 0;
  late Timer _timer;
  final List<String> _images = ['images/pikachu-1.jpg','images/pikachu-2.jpg','images/pikachu-3.jpg'];
  late String _image;
  int imageCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10000), (timer) => move());
    _image = _images[0];
  }

  @override
  Widget build(BuildContext context) {
    // Get Mediasize
    Size screenSize = MediaQuery.of(context).size;

    double bigBoxWidthSize = screenSize.width ~/ 100 * 100;
    double bigBoxHeightSize = bigBoxWidthSize * 1.5;

    return Container(
      color: Colors.red[300],
      child: Column(
        children: [
          Container(
            height: bigBoxHeightSize,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(_degree / 360),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(_image),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/pikachu-2.jpg'),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/pikachu-3.jpg'),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                ],
              ),
            ),
          ),
          Text(_degree.toString()),
          ElevatedButton.icon(
            onPressed: () => start(),
            label: Text(_isStart ? 'stop' : 'start'),
          ),
        ],
      ),
    );
  }

  // == Functions
  start() {
    _isStart = !_isStart;
    _timer.cancel();
    if (_isStart) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) => move());
    } else {
      _isStart = false;
      _degree = 0;
    }

    setState(() {});
  }

  move() {
    _degree += 15;
    if(imageCount>=3){
      imageCount = 0;
    }else{
    _image = _images[imageCount];
    imageCount++;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
