import 'package:flutter/material.dart';

class Banner2 extends StatelessWidget {
  const Banner2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/austria.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/belgium.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/estonia.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/france.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/germany.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/hungary.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/italy.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/lithuania.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/luxemburg.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/netherland.png'),
            radius: 40,
          ),

          // Image.asset('assets/images/belgium.png', width: 100),
          // Image.asset('assets/images/estonia.png', width: 100),
          // Image.asset('assets/images/france.png', width: 100),
          // Image.asset('assets/images/germany.png', width: 100),
          // Image.asset('assets/images/hungary.png', width: 100),
          // Image.asset('assets/images/italy.png', width: 100),
          // Image.asset('assets/images/lithuania.png', width: 100),
          // Image.asset('assets/images/luxemburg.png', width: 100),
          // Image.asset('assets/images/netherland.png', width: 100),
        ],
      ),
    );
  }
}
