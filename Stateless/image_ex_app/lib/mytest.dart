import 'package:flutter/material.dart';

class MyTest extends StatelessWidget {
  const MyTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      children: [
        Image.asset('images/pikachu-1.jpg',width:200),
        Image.asset('images/pikachu-2.jpg',width:200),
        Image.asset('images/pikachu-3.jpg',width:200),
      ],
    ));
  }
}
