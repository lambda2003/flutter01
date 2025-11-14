

import 'package:flutter/material.dart';
import 'package:image_ex_app/mytest.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Image Padding'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MyTest(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child:
                  Image.asset(
                    'images/pikachu-1.jpg',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
             
            
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: 
                  Image.asset(
                    'images/pikachu-2.jpg',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
               
                
              ),
          
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10,20,20),
         
              child: Image.asset(
                    'images/pikachu-3.jpg',
                    width: 150,
                    fit: BoxFit.contain,
                  )
            
        
            ),

          ],
        ),
      ),
    );
    
    
  }
}