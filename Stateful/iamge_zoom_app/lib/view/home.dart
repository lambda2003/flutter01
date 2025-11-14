import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String _image;
  bool _isOn = false;
  bool _isBig = false;
  bool _isRed = false;
  bool _isRemove = false;
  double _quarterTurn = 0.0;
  final List<String> rotateLable = ['정상', '90도', '180도', '240도', '360도'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = 'images/lamp_off.png';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double baseWidth = screenSize.width ~/ 120 * 100;
    double baseHeight = baseWidth * 1.5;

    double bigWidth = baseWidth / 1.1;
    double bigHeight = bigWidth * 1.5;

    double smallWidth = bigWidth / 1.6;
    double smallHeight = smallWidth * 1.5;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: baseWidth,
                height: baseHeight,
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    SimpleGestureDetector(
                      onDoubleTap: () => sizeUpDown(!_isBig),
                      child: Container(
                        width: _isBig ? bigWidth : smallWidth,
                        height: _isBig ? bigHeight : smallHeight,
                        // decoration: BoxDecoration(
                        //   // border: BoxBorder.all(color: Colors.black),
                        //   // color: Colors.green,
                      
                        //   // color:Colors.red,
                        // ),
                      
                        child: RotatedBox(
                          quarterTurns: _quarterTurn.toInt(),
                          child: Image.asset(
                            _image,
                      
                            // width: _isBig? bigWidth : smallWidth,
                            // height:_isBig? bigHeight : smallHeight
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 80,
                //   child: ElevatedButton(
                //     onPressed: ()=>sizeUpDown(),
                //     child: Text(_isBig? 'Small':'Big'),
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsetsGeometry.all(0.0),
                //     )
                //   ),
                // ),
                Column(
                  children: [
                    Text(_isBig ? 'Big' : 'Small'),
                    Switch(
                      value: _isBig,
                      onChanged: (value) => sizeUpDown(value),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(_isOn ? 'On' : 'Off'),
                    Switch(
                      value: _isOn,
                      onChanged: (value) => switchOnOff(value),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(_isRed ? 'Red' : 'Yellow'),
                    Switch(
                      value: _isRed,
                      onChanged: (value) => switchColor(value),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(_isRemove ? '삭제' : '생성'),
                    Switch(
                      value: _isRemove,
                      onChanged: (value) => switchRemove(value),
                    ),
                  ],
                ),
              ],
            ),
          
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Rotate - ${rotateLable[_quarterTurn.toInt()]}'),
                  Slider(
                    value: _quarterTurn,
                    min: 0,
                    max: 4,
                    divisions: 4,
                    onChanged: (value) => rotate(value),
                    label: '${rotateLable[_quarterTurn.toInt()]}',
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  // === Functions
  rotate(double value) {
    _quarterTurn = value;
    // if (_quarterTurn == 4) {
    //   _isOn = true;
    //   _image = 'images/lamp_red.png';
    //   _isRed = true;
    // }

    setState(() {});
  }

  switchColor(bool value) {
    if (_isRemove) {
      _image = 'images/lamp_remove.png';
    } else {
      if (_isOn) {
        _isRed = value;
        _image = _isRed ? 'images/lamp_red.png' : 'images/lamp_on.png';
      } else {
        _image = 'images/lamp_off.png';
      }
    }
    // _image = _isRemove
    //     ? 'images/lamp_remove.png'
    //     : !_isOn
    //     ? 'images/lamp_off.png'
    //     : _isRed
    //     ? 'images/lamp_red.png'
    //     : 'images/lamp_on.png';
    setState(() {});
  }

  sizeUpDown(bool value) {
    _isBig = value;
    setState(() {});
  }

  switchRemove(bool value) {
    _isRemove = value;
    if (!_isRemove)
      _image = !_isOn
          ? 'images/lamp_off.png'
          : _isRed
          ? 'images/lamp_red.png'
          : 'images/lamp_on.png';
    else
      _image = 'images/lamp_remove.png';
    setState(() {});
  }

  switchOnOff(bool value) {
    if (_isRemove) {
      _image = 'images/lamp_remove.png';
    } else {
      _isOn = value;
      if (_isOn) {
        _image = _isRed ? 'images/lamp_red.png' : 'images/lamp_on.png';
      } else {
        _image = 'images/lamp_off.png';
        _isRed = false;
      }
    }
    setState(() {});
  }
}
