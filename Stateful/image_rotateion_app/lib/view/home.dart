import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _degreeValue = 0;        // angle degree for rotation.
  bool _isClockwise = false;      // rotation direction
  bool _isStart = false;          // animation start
  bool _isRed = false;            // lamp: color change
  bool _isOn = false;             // lamp: on/off
  String _image = 'images/lamp_off.png';  // default image
  late Timer _t;                  // timer
  bool _isConfirmed = false;      // AlertDialog confirm

  @override
  void initState() {
    
    super.initState();
    // timer init then cancel
    // isStart 버튼이 시작될때 timer를 생성하기 위함. 
    _t = Timer.periodic(Duration(milliseconds: 1000), (timer) => _move());
    _t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RotationTransition(
              // 각도
              turns: AlwaysStoppedAnimation(_degreeValue / 360),
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Image.asset(_image, height: 300),
                  Text(_isOn? '전기를 아껴씁시다.':'',style:TextStyle(
                    fontSize: 15+_degreeValue/10,
                    color: Colors.black45,
                  )),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Column(
                children: [
                  Slider(
                    value: _degreeValue < 0 ? 0 : _degreeValue,
                    min: 0,
                    max: 361,
                    divisions: 20,
                    onChanged: (value) => changeDegree(value),
                    label: '${_degreeValue}',
                  ),
                  Text(_degreeValue.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(!_isClockwise ? '시계방향' : '시계반대'),
                          Switch(
                            value: _isClockwise,
                            onChanged: (value) => changeClockwise(value),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${_isRed ? '빨강' : '노랑'}'),
                          Switch(
                            value: _isRed,
                            onChanged: (value) => changeColor(value),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${_isOn ? '켜짐' : '꺼짐'}'),
                          Switch(
                            value: _isOn,
                            onChanged: (value) => changeOnOff(value),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Animation'),
                          ElevatedButton.icon(
                            onPressed: () => _run(!_isStart),
                            icon: Icon(
                              _isStart ? Icons.play_arrow : Icons.stop,
                            ),
                            label: Text('${_isStart ? 'Start' : 'Stop'}'),
                          ),

                          // Switch(
                          //   value: _isStart,
                          //   onChanged: (value) => _run(value),
                          // ),
                        ],
                      ),
                    ],
                  ),

                  // Column(
                  //   children: [
                  //     Text('${_isStart ? 'Started' : 'Stopped'}'),
                  //     ElevatedButton.icon(
                  //       onPressed: ()=>_run(!_isStart),
                  //       icon:  Icon(_isStart ? Icons.play_arrow : Icons.stop),
                  //       label: Text('${_isStart ? 'Start' : 'Stop'}'),
                  //     ),

                  //     // Switch(
                  //     //   value: _isStart,
                  //     //   onChanged: (value) => _run(value),
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Function
  _move() async {
    bool isLive = true;
    // if (_isOn) {
    if (_isStart) {
      if (_degreeValue <= 0) {
        _degreeValue = 360;
      } else if (_degreeValue >= 360) {
        _degreeValue = 0;

        // !_isClockwise ? _degreeValue += 15 : _degreeValue -= 15;
      } else {
        // !_isClockwise ? _degreeValue += 15 : _degreeValue -= 15;
      }
      !_isClockwise ? _degreeValue += 15 : _degreeValue -= 15;
      setState(() {});
    }

    // }
  }

  changeOnOff(bool value) async {
    // 컨펌 박스 헨들링
    if (value) {
      // Switch가 true로 들어왔음.
      // lamp를 킬것인지 컨펌 메세지를 보여준다.
      await _showDialog(context, "램프를 켜시겠습니까?");

      // 컨펌이 yes 라면, 
      // _isConfirm은 showDialog박스에서 헨들해 주었음. 
      if (_isConfirmed) {
        _isOn = true;
        _image = 'images/lamp_on.png';
      }
    } else {
      // Switch가 false로 들어왔음.
      // lamp를 끌것인지 컨펌 메세지를 보여준다.
      await _showDialog(context, "램프를 끄시겠습니까?");

      // 컨펌이 yes라면
      // _isConfirm은 showDialog박스에서 헨들해 주었음. 
      if (_isConfirmed) _isOn = false;
       _image = 'images/lamp_off.png';
    }
    setState(() {});

    // 컨펌박스를 넣어서 빼주었음. 
    // // _isOn = value;
    // if (_isOn) {
    //   // Show Confirm Message //
    //   _image = 'images/lamp_on.png';
    // } else {
    //   // _degreeValue = 0;
    //   _image = 'images/lamp_off.png';
    //   // _isStart = false;
    //   // _isClockwise = false;
    //   // _isRed = false;
    //   // _t.cancel();
    // }
    // setState(() {});
  }


  // RUN Button
  _run(bool value) async {
    // if (_isOn) {
    _isStart = value;
    if (_isStart) {
      _t.cancel();
      if (_degreeValue <= 0) _degreeValue = 1;
      _t = Timer.periodic(
        Duration(milliseconds: 100),
        (timer) async => await _move(),
      );
    } else {
      _t.cancel();
      _isClockwise = false;
      _degreeValue = 0.0;
      _degreeValue = 0;
      _image = 'images/lamp_off.png';
      _isStart = false;
      _isClockwise = false;
      _isRed = false;
    }
    setState(() {});
    // } else {
    //   // _t.cancel();
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(content: Text('Warn: Please turn light on first.')),
    //   // );
    // }
  }

  changeColor(bool value) {
    if (_isOn) {
      _isRed = value;
      _image = _isRed ? 'images/lamp_red.png' : 'images/lamp_on.png';
      setState(() {});
    } else {
      // _image ='images/lamp_off.png';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ware: Please turn light on first.')),
      );
    }
  }
 
  changeDegree(value) {
    _degreeValue = value;

    setState(() {});
  }

  changeClockwise(bool value) {
    _isClockwise = value;
    setState(() {});
  }

  _showDialog(BuildContext context, String msg) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey,
      // barrierLabel: 'aaa',
      builder: (context) {
        return AlertDialog(
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            textDirection: TextDirection.ltr,

            children: [
              Icon(Icons.info),
              Text(
                'Confirm Message',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          content: SizedBox(
            width: 100,
            height: 100,

            child: Center(
              child: Text(msg),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [Text(_msg)],
              // ),
            ),
          ),

          // backgroundColor: Colors.deepPurple[100],

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isConfirmed = true;
                setState(() {});
              },

              child: Text('네'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isConfirmed = false;
                setState(() {});
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('아니요'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }
}
