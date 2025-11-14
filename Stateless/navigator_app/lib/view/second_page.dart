import 'package:flutter/material.dart';
import 'package:navigator_app/view/functions.dart';
import 'package:navigator_app/view/thrid_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // 현재것을 지우겠다. FirstPage는 항상 살아 있음. 
                // 화면을 옮긴다고 FirstPage는 사라지지 않음. 
                // Navigator.pop(context);
                removeContext(context);
                snackBarFunction(context, 'Elevated', 1, Colors.red, 'Back to page');
              },
              child: Text('Go to the 1 page'),
            ),
            ElevatedButton(
              onPressed: () {
                snackBarFunction(context, 'Elevated', 1, Colors.blue, 'Move to Page 3');
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ThridPage();
                  }
                ));
              },
              child: Text('Go to the 3 page'),
            ),
          ],
        ),
      ),
    );
  }
}
