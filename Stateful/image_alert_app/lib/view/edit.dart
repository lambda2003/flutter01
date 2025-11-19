import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  // Property
  TextEditingController _controller = TextEditingController();
  var args = Get.arguments ?? {'title': '', 'isOn': false};
  //  {'title':_controller.text.trim(), 'isOn':_isOn}
  late bool _isOn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOn = args['isOn'];
    _controller.text = args["title"];
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
        title: Text('수정화면'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: '글자를 넣으세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isOn ? 'On' : 'Off'),
                    Switch(value: _isOn, onChanged: (value) => setOnOff(value)),
                  ],
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () => editItem(), 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            child: Text('수정')),
        ],
      ),
    );
  }

  // == Functions
  setOnOff(bool value) {
    _isOn = value;
    setState(() {});
  }

  editItem() {
    if (!_controller.text.trim().isEmpty) {
      Get.back(
        result: 
        {
          'title': _controller.text.trim(),
          'isOn': _isOn});
    }
  }
}
