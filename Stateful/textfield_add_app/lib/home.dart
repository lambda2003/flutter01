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
  late String _calculateResult;
  int _errorCode = 0;
  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    _calculateResult = '';
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('덧셈구하기'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          
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
                  color: _errorCode==901? Colors.red: Colors.black,
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
                  color: _errorCode==902? Colors.red: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => inputCheck(),
              child: Text('출력')
            ),
      
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(_calculateResult,style: TextStyle(color:Colors.red),),
            ),
        ],)
      ),
    );
  }

  // == Function
  void _sendSnackMessage(BuildContext context, String type, String msg) {
 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type : $msg'),
        backgroundColor: type == 'warn' ? Colors.orange: type == 'error' ? Colors.red : Colors.green,
        duration: Duration(seconds: 1),
      )
    );
  }
  
  _reset() {
   
      textEditingController1.clear();
      textEditingController2.clear();
    
  }
  bool _isNumber(String input){
      return  input.trim().contains(RegExp(r'(\d+)'));
  }
  inputCheck() {
    if(textEditingController1.text.trim().isNotEmpty 
      && textEditingController2.text.trim().isNotEmpty
      && _isNumber(textEditingController1.text)
      && _isNumber(textEditingController2.text)
    ){
       // 정상
      String v1 = textEditingController1.text.trim();
      String v2 = textEditingController2.text.trim();
      int result = int.parse(v1)+int.parse(v2);
    
       setState(() {
          _calculateResult = '입력하신 숫자의 $v1 + $v2 = ${result}입니다.';
          _errorCode = 0;
       },);
     
      // _sendSnackMessage(context,'info', textEditingController1.text.trim());
    }else{
      // 비정상
      String msg = '숫자를 입력하세요.';
      int errorNum = 900;
      if(!_isNumber(textEditingController1.text)){
        msg = 'Filed 1에 숫자를 입력하세요.';
        errorNum = 901;
      }else if(!_isNumber(textEditingController2.text)){
        msg = 'Filed 2에 숫자를 입력하세요.';
        errorNum = 902;
      }
      setState(() {
        _errorCode = errorNum;
      });
      _sendSnackMessage(context,'warn', msg);
      
    }



  }
  



}