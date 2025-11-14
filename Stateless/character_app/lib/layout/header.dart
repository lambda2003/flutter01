import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0,0),
      child: Column(
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/Lee.jpg'),
            radius: 50,
          ),
          Divider(height: 5),
        ],
      ),
    );
  }
}
