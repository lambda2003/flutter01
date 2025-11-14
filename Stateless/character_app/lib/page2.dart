
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text('Single->page'),
       
        // ElevatedButton(onPressed: () => {
        //   Navigator.of(context).pushNamed('/page2')
        // }, child: Text('button1')),
        ],
      )
    )
    );
      
     
  }
}
