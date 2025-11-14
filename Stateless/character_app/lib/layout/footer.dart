import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          Divider(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/turtle.gif'),
                radius: 20,
                backgroundColor: Colors.orange[300],
              ),
              Text('Footer'),
            ],
          ),
        ],
      ),
    );
  }
}

