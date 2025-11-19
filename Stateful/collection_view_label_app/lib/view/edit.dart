import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController _controller;
  var args = Get.arguments ?? null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(args == null){
      Get.back();
    }else{
      _controller = TextEditingController();
      _controller.text = args["data"];
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('인물변경')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '인물이름 바꾸기',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              onPressed: () => edit(),
              child: Text('변경'),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  edit() {
    if (_controller.text.trim().isNotEmpty) {
      Get.back(result: {"data":_controller.text.trim(),"index":args['index']});
    } else {
      Get.snackbar('알림', '변경 인물을 입력해 주세요.');
    }
  }
}
