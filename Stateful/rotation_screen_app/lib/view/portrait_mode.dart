import 'package:flutter/material.dart';

class PortraitMode extends StatefulWidget {
  const PortraitMode({super.key});

  @override
  State<PortraitMode> createState() => _PortraitModeState();
}

class _PortraitModeState extends State<PortraitMode> {

  late bool _isHello = true;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Portrait Mode adsf========'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHello? Colors.blue: Colors.red,
                foregroundColor: Colors.white,
              ) ,
              onPressed: (){
                _isHello = !_isHello;
                setState(() {
                  
                });
              }, 
              child:Text('${_isHello? 'Hello' : 'Flutter'}')
            )
          ]  
        );
    
  }
}