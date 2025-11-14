

import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text With Column and Row'),
        backgroundColor: Colors.purple,
      ),
      body: Center( 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.email_rounded)
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.account_circle)
                ),
                 Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.account_balance)
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('James')
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Cathy')
                ),
                 Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Kenny')
                ),
              ],
            ),
          ],
        )
             
      ),

          
        
      );
  }
}