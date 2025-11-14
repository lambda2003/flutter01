
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUTTON EXAMPLE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('a'),
            Text('b'),
            
          ],
        )
      ),
    );
  }
}

// class MyButton extends ElevatedButton {
//   const MyButton({
//     super.key,
//     required super.onPressed,
//     super.onLongPress,
//     super.onHover,
//     super.onFocusChange,
//     super.style,
//     super.focusNode,
//     super.autofocus = false,
//     super.clipBehavior,
//     super.statesController,
//     required super.child,
//   });

//   @override
//   // TODO: implement onPressed
//   VoidCallback? get onPressed => super.onPressed;
// }