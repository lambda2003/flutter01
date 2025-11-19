import 'dart:collection';

import 'package:bmi_pickview_app/vm/calc_bmi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _result = "";
  String _bmiImage = 'risk.png';
  int _height = 160;
  int _weight = 60;
  late CalcBmi calBmi;
  bool _imageLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calBmi = CalcBmi();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _imageLoaded? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('신장'),
                    SizedBox(
                      width: 150,
                      height: 150,

                      child: CupertinoPicker(
                        itemExtent: 35,
                        onSelectedItemChanged: (value) => run('height', value),

                        scrollController: FixedExtentScrollController(
                          initialItem: 60,
                        ),
                        children: List.generate(
                          100,
                          (index) => SizedBox(child: Text('${100 + (index)}')),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('몸무게'),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CupertinoPicker(
                        itemExtent: 35,
                        onSelectedItemChanged: (value) => run('weight', value),
                        scrollController: FixedExtentScrollController(
                          initialItem: 30,
                        ),
                        children: List.generate(
                          170,
                          (index) => SizedBox(child: Text('${30 + (index)}')),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(_result, style: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 200,
              
               
              child: Image.asset('images/$_bmiImage') ),
          ],
        ):Center(child:CircularProgressIndicator()),
      ),
    );
  }

  // Functions
   Future<void> _loadImage() async {
      
        ImageProvider imageProvider = AssetImage('images/bmi.png');
        await precacheImage(imageProvider, context);
        imageProvider = AssetImage('images/normal.png');
        await precacheImage(imageProvider, context);
        imageProvider = AssetImage('images/obese.png');
        await precacheImage(imageProvider, context);
        imageProvider = AssetImage('images/overweight.png');
        await precacheImage(imageProvider, context);
        imageProvider = AssetImage('images/risk.png');
        await precacheImage(imageProvider, context);
        
        setState(() {
          _imageLoaded = true;
        });
      }
  run(String type, int value) {
    if (type == 'height') {
      _height = 100 + value;
    } else {
      _weight = 30 + value;
    }

    // Calculate
    calBmi.setCalcBmi(_weight.toString(), _height.toString());
    (String, String, String) resultCalc = calBmi.calcAction();

    // print(resultCalc);
    _result = '귀하의 bmi지수는 ${resultCalc.$1} 이고 ${resultCalc.$2}입니다. ';
    _bmiImage = resultCalc.$3;
   
    setState(() {});
   
  }

  reset() {
    setState(() {
      _result = '';

      _bmiImage = 'risk.png';
    });
  }
}
