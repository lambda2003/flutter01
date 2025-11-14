import 'package:ex_textfield_app/functions/G_Calculator.dart';
import 'package:ex_textfield_app/view_model/general.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Propery
  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;
  late List<Widget> _calculateResult;
  int _errorCode = 0;

  bool _isPlus = false;
  bool _isMinus = false;
  bool _isMul = false;
  bool _isDivide = false;

  late SimpleCal calculator;
  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    _calculateResult = [];
    calculator = SimpleCal();
        print('Home calculator => ${calculator.hashCode}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('덧셈구하기'), backgroundColor: Colors.blue),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: textEditingController1,
                    decoration: InputDecoration(
                      labelText: '숫자를 입력 하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // hintText: '숫자 입력 가능 합니다.',
                      // hintStyle: TextStyle(
                      //   color: Colors.grey[500],
                      //   fontSize: 14,
                      // )
                    ),
                    // DEFAULT는 텍스트
                    // TextInputType.numberWithOptions()
                    keyboardType: TextInputType.number,
                    // onTap: () {
                    //   if(_errorCode == 0){
                    //     _reset();
                    //   }
                    // },
                    style: TextStyle(
                      color: _errorCode == 901 ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: textEditingController2,
                    decoration: InputDecoration(
                      labelText: '숫자를 입력 하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // DEFAULT는 텍스트
                    // TextInputType.numberWithOptions()
                    keyboardType: TextInputType.number,
                    // onTap: () {
                    //   if(_errorCode == 0){
                    //     _reset();
                    //   }
                    // },
                    style: TextStyle(
                      color: _errorCode == 902 ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => inputCheck(),
                      child: Text('출력'),
                    ),
                    ElevatedButton(
                      onPressed: () => _reset(),
                      child: Text('초기화'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('덧셈'),
                    Switch(
                      value: _isPlus,
                      onChanged: (value) => updateSwitchStatus('plus', value),
                    ),
                    Text('뺄셈'),
                    Switch(
                      value: _isMinus,
                      onChanged: (value) => updateSwitchStatus('minus', value),
                    ),
                    Text('곱셈'),
                    Switch(
                      value: _isMul,
                      onChanged: (value) => updateSwitchStatus('mul', value),
                    ),
                    Text('나눗셈'),
                    Switch(
                      value: _isDivide,
                      onChanged: (value) => updateSwitchStatus('div', value),
                    ),
                  ],
                ),

                Text(
                  "isPlus = ${_isPlus.toString()} , ${_isMinus.toString()} , ${_isMul.toString()} , ${_isDivide.toString()}   ",
                ),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pushNamed('/page');
                }, child: Text('Page1')),
                Text(calculator.hashCode.toString()),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _calculateResult,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // == Function
  // void _sendSnackMessage(BuildContext context, String type, String msg) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('${type.toUpperCase()} : $msg'),
  //       backgroundColor: type == 'warn'
  //           ? Colors.orange
  //           : type == 'error'
  //           ? Colors.red
  //           : Colors.green,
  //       duration: Duration(seconds: 1),
  //     ),
  //   );
  // }

  _reset() {
    General.reset([textEditingController1,textEditingController2]);
    // textEditingController1.clear();
    // textEditingController2.clear();

    updateSwitchStatus('all', false); // status변경
  }



  // bool _isNumber(String input) {
  //   return input.trim().contains(RegExp(r'(\d+)'));
  // }

  inputCheck() {
    if (textEditingController1.text.trim().isNotEmpty &&
        textEditingController2.text.trim().isNotEmpty &&
        General.isNumber(textEditingController1.text) &&
        General.isNumber(textEditingController2.text) &&
        (_isPlus || _isMinus || _isMul || _isDivide)) {
      // 정상
      int v1 = int.parse(textEditingController1.text.trim());
      int v2 = int.parse(textEditingController2.text.trim());

      updateResult(v1, v2); // status변경

      // _sendSnackMessage(context,'info', textEditingController1.text.trim());
    } else {
      // 비정상
      String msg = '사칙연산중 적어도 하나를 선택하셔야 합니다.';
      int errorNum = 900;
      if (!General.isNumber(textEditingController1.text)) {
        msg = 'Filed 1에 숫자를 입력하세요.';
        errorNum = 901;
      } else if (!General.isNumber(textEditingController2.text)) {
        msg = 'Filed 2에 숫자를 입력하세요.';
        errorNum = 902;
      }
      if (_isPlus || _isMinus || _isMul || _isDivide) msg = '숫자를 입력하세요';
      updateErrorCode(errorNum); // status변경
      General.sendSnackMessage(context, 'warn', msg);
    }
  }

  // === Status 변경
  
  updateSwitchStatus(String type, bool value) {
    setState(() {
      switch (type) {
        case 'plus':
          _isPlus = value;
          break;
        case 'minus':
          _isMinus = value;
          break;
        case 'mul':
          _isMul = value;
        case 'div':
          _isDivide = value;
          break;
        default:
          _isPlus = value;
          _isMinus = value;
          _isMul = value;
          _isDivide = value;
          _calculateResult = [];
      }

      // type == 'plus'
      //     ? _isPlus = value
      //     : type == 'minus'
      //     ? _isMinus = value
      //     : type == 'mul'
      //     ? _isMul = value
      //     : _isDivide? _isDivide = value
      //     : {_isPlus= false; _isMinus= false,}
    });
  }
  updateErrorCode(int code){
    setState(() {
      _errorCode = code;
    });
  }
  updateResult(int v1, int v2) {
    int plus = _isPlus ? calculator.plus(v1, v2) : 0;
    int minus = _isMinus ? calculator.minus(v1, v2) : 0;
    int multi = _isMul ? calculator.multi(v1, v2) : 0;
    double divide = _isDivide ? calculator.divide(v1, v2) : 0;
    setState(() {
      _calculateResult = [
        Row(
          children: [
            Text('덧셈 :'),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10.0),
              child: Text(plus.toString()),
              color: Colors.grey[200],
            ),
          ],
        ),

        Row(
          children: [
            Text('뺄셈 :'),
            Container(
              width: 300,
              padding: const EdgeInsets.all(8.0),
              child: Text(minus.toString()),
              color: Colors.grey[200],
            ),
          ],
        ),

        Row(
          children: [
            Text('곱셈 :'),
            Container(
              width: 300,
              padding: const EdgeInsets.all(8.0),
              child: Text(multi.toString()),
              color: Colors.grey[200],
            ),
          ],
        ),

        Row(
          children: [
            Text('나눗셈:'),
            Container(
              width: 290,
              padding: const EdgeInsets.all(8.0),
              child: Text(divide.toString()),
              color: Colors.grey[200],
            ),
          ],
        ),
      ];
      _errorCode = 0;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    print("===== home displosed");
    super.dispose();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    print('==== Home deactivated');
    super.deactivate();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print('======== home setState called');
  }

  
}
