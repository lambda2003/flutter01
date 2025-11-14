import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  //
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(children: listObj),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () => createObject(),
                //   child: Text('Create'),
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () => deleteObject(false),
                //   child: Text('Delete'),
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () => deleteObject(true),
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => start(),
                  child: !_isOn?Text('Start'):Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOn ? Colors.orange : Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => setState(() => changeStatus(null)),
              child: Text('Flutter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOn ? Colors.orange : Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Switch(value: _isOn, onChanged: (value) => changeStatus(value)),
          ],
        ),
      ),
    );
  }

  // ==== Functions
  void changeStatus(bool? value) {
    setState(
      () => _isOn = value != null
          ? _isOn = value
          : _isOn
          ? false
          : true,
    );
  }

  List<Widget> listObj = [];
  void _createObject() {
    setState(() {
      listObj.add(Text('aaaa'));
    });
  }

  Future<void> start() async {
    int x = 0;
    changeStatus(!_isOn);
   
      while (true) {
        if (!_isOn || x > 10) {
          print('breaked');
          break;
        }
        _createObject();
        x++;
        print(x);
        await Future.delayed(Duration(seconds: 2));
      }
 
  }

  void deleteObject(bool isAll) {
    setState(() {
      if (!isAll)
        listObj.removeLast();
      else{
        _isOn = false;
        listObj.removeRange(0, listObj.length);
      }
    });
  }
}
