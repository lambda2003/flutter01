import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  // State는 private (보안을 위함)
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String _buttonState;
  late Color _appBarColor;
  buttonChange() {
    setState(() {
      if (_buttonState == 'OFF') {
        _buttonState = 'ON';
        _appBarColor = Colors.red;
      } else {
        _buttonState = 'OFF';
        _appBarColor = Colors.green;
      }
    });
    // print(getData());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buttonState = 'OFF';
    _appBarColor = Colors.green;
    print(getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stateful 1'), backgroundColor: _appBarColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => buttonChange(),
              child: _buttonState == "ON"
                  ? Text('로그오프', style: TextStyle(color: Colors.white))
                  : Text('로그인', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                //
                backgroundColor: _buttonState == "ON"
                    ? Colors.grey
                    : Colors.blue,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('버튼 상태 : '),

                Text(
                  _buttonState,
                  style: TextStyle(
                    color: _buttonState == "OFF" ? Colors.black : Colors.red,
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'aaaa';
  }
}
