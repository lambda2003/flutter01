import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글자 일력후 enter키를 눌렀을때 반응')
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "글자를 입력하세요"),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) => submit(value),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  submit(value) {
    if (_controller.text.trim() == '' || _controller.text.trim().isEmpty) {
      // SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          
          content: Text('Empty'),
        )
      );
    } else {
      // 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          
          content: Text('${_controller.text.trim()}'),
        )
      );
    }
  }
}
