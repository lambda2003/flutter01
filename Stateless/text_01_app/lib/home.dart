import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Column(
                  children: [
                    Text('James'),
                    Text('제임스')
                  ],
                  
                ),
                
                // SizedBox(
                //   width: 25,
                // ),
                Column(
                  children: [
                    Text('Cathy'),
                    Text('캐시')
                  ],
                ),
                
                // SizedBox(
                //   width: 25,
                // ),
                Column(
                  children: [
                    Text('Kenny'),
                    Text('캐니')
                  ],
                ),
              ],
            ),
          ]
        )
      ),
  
    );
  }
}