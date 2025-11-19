import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  String _imagePath = 'images/lamp_on.png';
  bool _isOn = true;
  double _turnValue = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // // Get Size of Screen
    // use the size to display image and container.
    // todo: store size data into Generic Store.
    Size screenSize = MediaQuery.of(context).size;
    double baseWidth = screenSize.width ~/ 100 * 100;
    double baseHeight = baseWidth * 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Main 화면'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: AlwaysStoppedAnimation(_turnValue / 360),
              child: Container(
                width: baseWidth / 3,
                child: Image.asset(_imagePath),
              ),
            ),
            ElevatedButton(onPressed: () => lampOnOff(true), child: Text('켜기')),
            ElevatedButton(
              onPressed: () => lampOnOff(false),
              child: Text('끄기'),
            ),
          ],
        ),
      ),
    );
  }

  lampOnOff(bool v) async {
    if ((_isOn && v) || (!_isOn && !v)) {
      // 불이 켜져 있습니다. dialog
      // await Get.defaultDialog(
      //   barrierDismissible: false,
      //   title: _isOn ? "램프가 켜져있는 상태입니다." : "램프가 꺼져있는 상태입니다.",
      //   content: ElevatedButton(
      //     onPressed: () => Get.back(),
      //     child: Text('네 알겠습니다.'),
      //   ),
      // );

       await showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
          // title: Text('aaaaa'),
          content:  _isOn ? Text("램프가 켜져있는 상태입니다.") : Text("램프가 꺼져있는 상태입니다."),
          actions: [
            CupertinoButton(child: Text('네 알겠습니다. '), onPressed: ()=>Get.back())
          ],
        
        )
      );

    }

    await showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        title: Text('램프끄기'),
        message: (v && _isOn) || (!v && _isOn)
            ? Text('램프끄시겠습니까?')
            : Text('램프켜시겠습니까?'),

        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              _isOn = !_isOn;
              if (_isOn)
                _imagePath = 'images/lamp_on.png';
              else
                _imagePath = 'images/lamp_off.png';

              setState(() {});
              Get.back();
            },
            child: Text('예'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('아니오'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
      ),
    );
  }
}
