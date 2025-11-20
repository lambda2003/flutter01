import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage_app/view/second_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController idController;
  late TextEditingController pwController;

  // 공용저장소 (다른 앱도 쓸수 있음)
  // 키값으로 access 함.
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    initStorage();
  }

  initStorage() {
    // 혹시 존재 할수 있으니 지우고 시작한다.
    box.write('p_userId', '');
    box.write('p_password', '');
  }

  @override
  void dispose() {
    box.erase();
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: '사용자 ID를 입력하세요'),
            ),
            TextField(
              controller: pwController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: '패스워드를 입력하세요'),
            ),
            ElevatedButton(onPressed: () => checkData(), child: Text('로그인')),
          ],
        ),
      ),
    );
  }

  // == Functions
  checkData() {
    if (idController.text.trim().isEmpty || pwController.text.trim().isEmpty) {
      // errorSnackBar;
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '환영 합니다',
      content: Text('신분이 확인됬습니다.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            saveStorage();
            Get.to(SecondPage());
          },
          child: Text('확인'),
        ),
      ],
    );
  }

  saveStorage(){
    box.write('p_userId', idController.text.trim());
    box.write('p_password', pwController.text.trim());
  }

}
