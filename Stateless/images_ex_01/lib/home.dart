import 'dart:io';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      appBar: AppBar(
        title: Text('Image Ex01'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/pikachu-1.jpg'),
              radius: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                 
                      
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'images/pikachu-2.jpg',
                          
                        ),
                        radius: 50,
                        child:  Text(
                          '푸하하',
                          style: TextStyle(
                            backgroundColor: Colors.green,
                          )
                        ) 
                      ),
                     
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                      CircleAvatar(
                        backgroundImage: AssetImage('images/pikachu-3.jpg'),
                        radius: 50,
                       
                      ),
                     
                
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
