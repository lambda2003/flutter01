import 'package:flutter/material.dart';
import 'package:navigator_class_app/function/general.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('SecondPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text('Screen 2nd'),
             ElevatedButton(
              style:ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              onPressed: () => Navigator.pushNamed(context, '/4th'),
              child: Text('Second Image Page')
            ),
              
          ],
        ),
      )
    );
  }
  
}