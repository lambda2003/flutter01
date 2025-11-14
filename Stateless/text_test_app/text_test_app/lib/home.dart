import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Emulator 01'),
        centerTitle: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '유비',
            ),

            Text(
              '관우',
              style: TextStyle(
                color: Colors.black,
              ),
              
            ),
            Text(
              '장비'
            ),
            // SizedBox(
            //   height: 50,
            // ),

            Divider(
              height: 30,
              color: Colors.red,
              thickness: 5,
            ),
            Text(
              '조조',
              style: TextStyle(
                color: Colors.blue,
                fontSize:28,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              )
            ),
            Text(
              '여포',
            ),
            Text(
              '동탁',
            ),
            Divider(
              height: 30,
              color: Colors.red,
              thickness: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '위',
                  textScaler: TextScaler.linear(2),
                ),
                Text(
                  '촉',
                  textScaler: TextScaler.linear(2),
                ),
                Text(
                  '오',
                  textScaler: TextScaler.linear(2),
                ),
              ],
            ),
            Text(
              '삼국지',
              textScaler: TextScaler.linear(3),
      
            ),
          ],
        ),
      ),
      
    );
  }

}