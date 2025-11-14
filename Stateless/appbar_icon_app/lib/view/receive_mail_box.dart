import 'package:flutter/material.dart';

class ReceiveMailBox extends StatelessWidget {
  const ReceiveMailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Received Mail'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
        child: Column(
          spacing: 2,
          children: [
          Text('111111'),
          Text('222222'),
          Text('333333')
        ],),
      )
    );
  }
}