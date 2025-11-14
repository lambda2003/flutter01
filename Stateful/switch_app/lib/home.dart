import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late bool _switchValue;
  late String _appBarTitle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _switchValue = true;
    _appBarTitle = '피카츄';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(children: [Text(_appBarTitle)]),
        backgroundColor: Colors.green,
        // leading: Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        //   child: CircleAvatar(
        //     radius: 5,
        //     backgroundImage: _switchValue
        //         ? AssetImage('images/pikachu-2.jpg')
        //         : AssetImage('images/smile.png'),
        //   ),
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            
            
            CircleAvatar(
              radius: 60,
              
              backgroundImage: _switchValue
                  ? AssetImage('images/pikachu-2.jpg')
                  : AssetImage('images/smile.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('스마일'),
                Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                      checkScreen();
                    });
                  },
                ),
                Text('피카츄'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============ Functions
  checkScreen() {
    print(_switchValue);
    setState(() {
      if (!_switchValue) {
        _appBarTitle = '스마일';
      } else {
        _appBarTitle = '피카츄';
      }
    });
  }
}
