import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Image'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
           
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset(
                      'images/smile.png',
                      width: 100,
                    ),
                    Image.asset(
                      'images/smile.png',
                      width: 100,
                    ),
                    Image.asset(
                      'images/smile.png',
                      width: 100,
                    ),
                    Image.asset(
                      'images/smile.png',
                      width: 100,
                    ),
                    Image.asset(
                      'images/smile.png',
                      width: 100,
                    ),
                  ]
                )
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
              Image.asset(
                'images/smile.png',
                width: 100,
              ),
            ],
          )
        ),
      ),
             
    );

        
  }
}