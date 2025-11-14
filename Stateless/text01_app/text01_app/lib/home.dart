import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text Row',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Text(
              'James'
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              'Cathy'
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              'Cany'
            ),
          ],
        ),
      ),
    );
  }
}