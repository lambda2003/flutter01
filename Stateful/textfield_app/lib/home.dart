import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Propery
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Textfield app')
      ),
      body: Column(
        
        children: [
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '글자를 입력 하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '텍스트만 입력 가능 합니다.',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                )
              ),
              // DEFAULT는 텍스트
              // TextInputType.numberWithOptions()
              keyboardType: TextInputType.text,
            ),
          ),
          ElevatedButton(
            onPressed: () => inputCheck(),
            child: Text('출력')
          ),
      ],)
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
  inputCheck() {
    if(textEditingController.text.trim().isNotEmpty){
       // 정상
      _sendSnackMessage(context,'info', textEditingController.text.trim());
    }else{
      // 비정상
      _sendSnackMessage(context,'warn', '글자를 입력하세요.');
    }
  }



}