import 'package:flutter/material.dart';
import 'package:images02_ex_app/home/banner2.dart';
import 'package:images02_ex_app/home/home_banner.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Scrolling'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              HomeBanner(),
              Banner2(),
              Text('A', style: TextStyle(fontSize: 65)),
              Text('B', style: TextStyle(fontSize: 65)),
              Text('C', style: TextStyle(fontSize: 65)),
              Text('D', style: TextStyle(fontSize: 65)),
              Text('E', style: TextStyle(fontSize: 65)),
              Text('F', style: TextStyle(fontSize: 65)),
              Text('G', style: TextStyle(fontSize: 65)),
            ],
          ),
        ),
      ),
    );
  }
}
