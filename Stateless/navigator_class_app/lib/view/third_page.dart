import 'package:flutter/material.dart';
import 'package:navigator_class_app/function/general.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('First Image Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundImage:  AssetImage('images/pikachu-1.jpg'),
              radius: 70,
            ),


            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
             
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: () => Navigator.pop(context), 
              icon: Icon(Icons.arrow_back),
              label: Text('Back to the 1st page')
            ),

            ElevatedButton.icon(
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              
              ),
              onPressed: () => removeContext(context), 
              icon: Icon(Icons.home),
              label: Text('Back to the home')
            ),
            
          ],
        ),
      )
    );
  }
}