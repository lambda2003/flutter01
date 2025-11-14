import 'package:bmi_image_app/vm/calc_bmi.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tc1 = TextEditingController();
  TextEditingController _tc2 = TextEditingController();
  String _result = "";
  late bool isValid;
  late String _bmiImage;
  late CalcBmi _calcBmi;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bmiImage = 'bmi.png';
    isValid = false;
    _calcBmi = CalcBmi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 65,
                      child: TextField(
                        controller: _tc1,
                        decoration: InputDecoration(
                          labelText: '키를 넣어 주세요.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 65,
                      child: TextField(
                        controller: _tc2,
                        decoration: InputDecoration(
                          labelText: '몸무게를 넣어주세요.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => calBMI(),
                      child: Text('계산하기'),
                    ),
                    ElevatedButton(
                      onPressed: () => reset(),
                      child: Text('초기화'),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(_result, style: TextStyle(color: Colors.red)),
                ),
                Image.asset('images/$_bmiImage'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNumber(String input) {
    bool r = input.trim().contains(RegExp(r'(\d+)'));
    // space handling
    r = !input.trim().contains(RegExp(r'(\ )'));
    return r;
  }

  reset() {
    setState(() {
      _result = '';
      _tc1.text = '';
      _tc2.text = '';
      _bmiImage = 'bmi.png';
    });
  }

  calBMI() {
    
    String msg = '숫자를 넣어 주세요(1)';
    if (_tc1.text.isEmpty || _tc2.text.isEmpty) {
      // Error
      msg = '숫자를 넣어 주세요(2)';
    } else {
      // check number

      if (isNumber(_tc1.text) && isNumber(_tc2.text)) {

        _calcBmi.setCalcBmi(_tc2.text.trim(),_tc1.text.trim());
        (String,String,String)resultCalc = _calcBmi.calcAction();
        
        
        
        setState(() {
          _result = '귀하의 bmi지수는 ${resultCalc.$1} 이고 ${resultCalc.$2}입니다. ';
         _bmiImage = resultCalc.$3;
        });

        // double height = int.parse(_tc1.text.trim()) / 100;
        // int weight = int.parse(_tc2.text.trim());
        // double bmi = weight / (height * height);
        // String n = '정상';
        // setState(() {
        //   if (bmi >= 30) {
        //     // 고도비만
        //     bmiImage = Image.asset('images/obese.png');
        //     n = '고도비만';
        //   } else if (bmi >= 25) {
        //     // 비만
        //     bmiImage = Image.asset('images/overweight.png');
        //     n = "비만";
        //   } else if (bmi >= 23) {
        //     //과체중
        //     bmiImage = Image.asset('images/risk.png');
        //     n = "과체중";
        //   } else if (bmi > 18.5) {
        //     // 정상
        //     bmiImage = Image.asset('images/normal.png');
        //     n = "정상";
        //   } else {
        //     //저체중
        //     bmiImage = Image.asset('images/underweight.png');
        //     n = "저체중";
        //   }
        //   _result = '귀하의 bmi지수는 ${bmi.toStringAsFixed(2)} 이고 $n입니다. ';
        // });
        msg = _result;
      }
    
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green));
  }
}
