import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/pikachu-1.jpg'),
            backgroundColor: Colors.white,
            radius: 80,
          ),
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-2.jpg'),
                backgroundColor: Colors.white,
                radius: 80,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-3.jpg'),
                backgroundColor: Colors.white,
                radius: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
