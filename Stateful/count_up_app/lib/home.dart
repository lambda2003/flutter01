import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  final String homeTitle = 'Parent Header';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  int _count = 0;
  bool _isMinus = false;
  int _isMinusNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.homeTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // padding: const EdgeInsets.fromLTRB(0,0,0,50),
              height: 300,

              child: CircleAvatar(
                // \(ax (1+r)^{n}\)
                foregroundColor: Colors.white,
                radius: _count > 0
                    ? 20 + (_count / 3).toDouble() * pow(1.05, _count)
                    : 0,
                backgroundImage: _count > 30
                    ? AssetImage('images/pikachu-1.jpg')
                    : _count > 20
                    ? AssetImage('images/pikachu-2.jpg')
                    : _count > 10
                    ? AssetImage('images/pikachu-3.jpg')
                    : null,
                child: _count > 30
                    ? Text('야호~')
                    : _count > 10
                    ? Text('안녕!!')
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text("현재 클릭수는 $_count"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Switch(
                  value: _isMinus,
                  onChanged: (value) {
                    setState(() {
                      _isMinus = value;

                      _isMinusNum = value ? 1 : 0;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () => _start(60),
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () => _start(0),
                  child: Text('Reset'),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () => _countFunc(),

            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         foregroundColor: Colors.white,
            //         shape: CircleBorder(
            //           eccentricity: 0.1,
            //           side: BorderSide(
            //             width: 0,
            //             color: const Color.fromARGB(255, 136, 136, 136),
            //           ),
            //         ),
            //       ),

            //       //   child: !_isMinus
            //       // ? Text('+', style: TextStyle(fontSize: 30))
            //       // : Text('-', style: TextStyle(fontSize: 30)),
            //       child: <Widget>[
            //         Text('+', style: TextStyle(fontSize: 30)),
            //         Text('-', style: TextStyle(fontSize: 30)),
            //       ][_isMinusNum],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: () => _countFunc(),
            backgroundColor: !_isMinus ? Colors.blue[200] : Colors.red[200],
            foregroundColor: Colors.white,
            child: <Widget>[
              Text('+', style: TextStyle(fontSize: 30)),
              Text('-', style: TextStyle(fontSize: 30)),
            ][_isMinusNum],
          ),
        ],
      ),
    );
  }

  // ===== Functions
  void _reset() {
    setState(() {
      _count = 0;
      _isMinus = false;
    });
  }

  void _countFunc() {
    setState(() {
      !_isMinus ? _count++ : _count--;
    });
  }

  Future<void> _start(int howmany) async {
    if (howmany == 0) {
      _reset();
    } else {
      int index = 0;
      while (true) {
        if (index > 100 || index >= howmany) break;
        _countFunc();
        index++;
        await Future.delayed(Duration(milliseconds: 200));
      }
    }
  }
}
