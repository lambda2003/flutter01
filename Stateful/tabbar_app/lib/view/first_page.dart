import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 500,
          color:Colors.red,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
              
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/pikachu-1.jpg'),
              ),
               CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-2.jpg'),
                radius: 60,
              ),
               CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-3.jpg'),
                radius: 60,
              )
            ],
          ),
        ),
      );
    
  }
}