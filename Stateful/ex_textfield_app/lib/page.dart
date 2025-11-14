import 'package:ex_textfield_app/functions/G_Calculator.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  
  late SimpleCal calculator;
  late Widget w;
  late bool isClose = true;
  @override
  void initState() {
    super.initState();
    w = Text('aa');
    calculator = SimpleCal();
    print('Page calculator => ${calculator.hashCode}');
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(child: w,)
    );
  }

  @override
  void activate() {
    // TODO: implement activate
    print('=== Page actived');
    super.activate();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate

      print('====Page deactivated');
      super.deactivate();
    
  }


  @override
  void dispose() {

    // TODO: implement dispose
    print('====Page disposed');
    super.dispose();

  }
}


