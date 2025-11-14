import 'package:flutter/material.dart';
import 'package:snackbar_app/widgets/snackbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnackBar'),
        centerTitle: true,
        backgroundColor: Colors.amber[200],
      ),
      body: const MySnackBar(),
    );
  } // Build

  // // ------- Functitons -------
  // snackBarFunction(BuildContext context,String buttonType,int second,Color bacgroundColor) {
  //   // 하단에 뜨는 Menu
  //   // memory와 많이 연관됨
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: bacgroundColor,
  //       duration: Duration(
  //         seconds: second,//buttonType=="Snackbar"? 1 : 3, // 1초
  //       ),

  //       content: Text('${buttonType} Button is clicked'),
  //     ), // SnackBar Widget (Style)
  //   ); // Dart
  // }

} // Class
