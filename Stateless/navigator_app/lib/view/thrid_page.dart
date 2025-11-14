import 'package:flutter/material.dart';
import 'package:navigator_app/view/functions.dart';

class ThridPage extends StatelessWidget {
  const ThridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Third Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                removeContext(context);
                snackBarFunction(context, 'Elevated', 1, Colors.red, 'back to page 2');
              },
              child: Text('Go to the 2 page'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.pop(context);
                // for(int i=0;i<5;i++){
                //   if(Navigator.canPop(context)){
                //     // The current route can be popped
                //     Navigator.pop(context);
                //   }else {
                //     break;
                //   }
                // }
                removeContext(context);
                snackBarFunction(context, 'Elevated', 1, Colors.red, 'Back to Page 1');
              },
              child: Text('Go to the 1 page'),
            ),
          ],
        ),
      ),
    );
  }
}
