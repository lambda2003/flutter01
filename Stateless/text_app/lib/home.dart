import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("삼국지"), // AppBar Widget 의 title parameter의 값은 "삼국지"
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 33, 131, 243),
        foregroundColor: Colors.white,
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( // 글자를 출력하는 위젯
                  '조조 aa',
                  // style: TextStyle(
                  //   color:Colors.white,
                  //   backgroundColor: Colors.red,
                   
                  // ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  '유비 bb'
                ),
              ],
            ),
            SizedBox(
              height:100
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '장비 cc'
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  '관우 dd'
                ),
              ],
            ),
          ],
        ),
      ),
    );
    //const Placeholder();
  }
}


