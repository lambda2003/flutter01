import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Fitting'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/smile.png',
              width: 1000,
              height: 100,
              fit: BoxFit.contain, // 작은값 따라서 비율로 보여줌
            ),
            Image.asset(
              'images/smile.png',
              width: 50,
              height: 100,
              fit: BoxFit.fill, // 나의 값에 따라 보여줌
            ),
            Image.asset(
              'images/smile.png',
              width: 50,
              height: 100,
              fit: BoxFit.cover, // 잘라서 보여줌
            ),
            Image.asset(
              'images/smile.png',
              width: 50,
              height: 100,
              fit: BoxFit.fitWidth, // width에 맞게
            ),
            Image.asset(
              'images/smile.png',
              width: 50,
              height: 100,
              fit: BoxFit.fitHeight, // height에 맞게 
            )


          ],
        )
      )
    );
  }
}

