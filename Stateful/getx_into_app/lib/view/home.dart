import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_into_app/view/second.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('>> Navigation'),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  Second(),
                  transition: Transition.circularReveal,
                  duration: Duration(milliseconds: 1000),
                );
              },
              child: Text('Get.to() : 화면이동'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/third');
              },
              child: Text('Get.toName() : 화면이동'),
            ),
            Divider(thickness: 5, color: Colors.grey),
            Text('Snackbar=='),
            ElevatedButton(
              onPressed: () => buttonSnack(),
              child: Text('Snackbar 보이기'),
            ),
            Divider(thickness: 5, color: Colors.grey),
            Text('Dialog=='),
            ElevatedButton(
              onPressed: () => buttonDialog(),
              child: Text('Dialog'),
            ),
            Divider(thickness: 5, color: Colors.grey),
            Text('>>> Bottom Sheet'),
            ElevatedButton(
              onPressed: () => buttonBottomSheet(),
              child: Text('Buttom Sheet 보이기'),
            ),
            Divider(thickness: 5, color: Colors.grey),
            Text('>>> Navigation & Arguments'),
            ElevatedButton(
              onPressed: () =>
                  Get.to(Second(), arguments: {'id': 1, 'title': 'aaa'}),
              child: Text('Get.to() : Single Argument'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(Second(), arguments: ['1111', '22222']),
              child: Text('Get.to() : Multiple Argument'),
            ),
            ElevatedButton(
              onPressed: () async {
                var returnValue = await Get.to(Second(), arguments: ['1111', '22222'],);
                
                Get.snackbar(
                  backgroundColor: Colors.green,
                  'TITLE', 
                  returnValue); 
              },
              child: Text('Get.to() : Return Argument'),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  buttonSnack() {
    Get.snackbar(
      "Snack Bar",
      "message",
      snackPosition: SnackPosition.TOP,
      duration: Duration(milliseconds: 2000),
      backgroundColor: Colors.red,
      colorText: Colors.amber,
    );
  }

  buttonDialog() {
    Get.defaultDialog(
      title: 'Dialog',
      middleText: 'Message',
      backgroundColor: Colors.green,
      barrierDismissible: false,
      actions: [TextButton(onPressed: () => Get.back(), child: Text('Exit'))],
    );
  }

  buttonBottomSheet() {
    Get.bottomSheet(
      Container(
        width: 300,
        height: 200,
        color: Colors.purpleAccent,
        child: Column(
          children: [
            TextButton(
              onPressed: () => Get.to(Second()),
              child: Text('Text Line1'),
            ),

            Text('Text Line2'),
          ],
        ),
      ),
    );
  }
}
