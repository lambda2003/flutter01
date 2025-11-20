
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // Property

  final box = GetStorage();
  late String userId;
  late String password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStorage();
  }

  initStorage() {
    
    userId = box.read('p_userId');
    password = box.read('p_password');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second'),
      ),
      body: Center(
        child:Column(
          children: [

            Text(userId),
            Text(password),
          ],
        )
      )
    );
  }
}