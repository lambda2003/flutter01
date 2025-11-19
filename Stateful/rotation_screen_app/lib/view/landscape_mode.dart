import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotation_screen_app/view/test.dart';

class LandscapeMode extends StatefulWidget {
  const LandscapeMode({super.key});

  @override
  State<LandscapeMode> createState() => _LandscapeModeState();
}

class _LandscapeModeState extends State<LandscapeMode> {
  late bool _isHello = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    print(screenWidth.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: screenWidth - (screenWidth / 3),
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Portrait Mode adsf========'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_isHello ? Colors.blue : Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _isHello = !_isHello;
                  setState(() {});
                },
                child: Text('${!_isHello ? 'Hello' : 'Flutter'}'),
              ),
              Switch(
                value: _isHello,
                onChanged: (value) {
                  _isHello = !_isHello;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Container(
          width: screenWidth / 3,
          height: screenHeight,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )
                  ),
                  onPressed: (){
                    Get.to(()=>Test());
                }, child: Text('Button 1')),
              ),
               SizedBox(
                width: screenWidth / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )
                  ),
                  onPressed: (){
                  
                }, child: Text('Button 2')),
              )
            ],
          ),
        ),
      ],
    );
  }
}
