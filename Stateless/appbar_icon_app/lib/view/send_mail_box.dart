import 'package:flutter/material.dart';

class SendMailBox extends StatelessWidget {
  const SendMailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Mail'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
        child: Column(
          spacing: 3,
          children: [
          Text('aaaaa'),
          Text('bbbb'),
          Text('cccc')
        ],),
      )
    );
  }
}