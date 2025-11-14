
import 'package:flutter/material.dart';
import 'package:navigator_app/view/functions.dart';
import 'package:navigator_app/view/second_page.dart';
import 'package:navigator_app/view/thrid_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('First Page'),
            ElevatedButton(
              onPressed: () {
                // 이동하는 방식.
                snackBarFunction(context, 'Elevated', 1, Colors.red, 'Move to Page 2');
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return SecondPage();
                    }
                ));
              }, 
              child: Text('Go to the 2 page')
            ),
             ElevatedButton(
              onPressed: () {
                // 이동하는 방식.
                snackBarFunction(context, 'Elevated', 1, Colors.blue, 'Move to Page 3');
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return ThridPage();
                    }
                ));
              }, 
              child: Text('Go to the 3 page')
            )
          ]
        ),
      )
    );
  }
}