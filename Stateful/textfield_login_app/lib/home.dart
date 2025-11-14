import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_login_app/model/user.dart';
import 'package:textfield_login_app/utils/generic.dart';
// import 'package:textfield_login_app/utils/generic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  late FocusNode idFocus;
  late FocusNode pwFocus;

  bool _isSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idFocus = FocusNode();
    pwFocus = FocusNode();
  }

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    idFocus.dispose();
    pwFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            Image.asset(!_isSuccess?'images/login.png':'images/cat.png', width: 150),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 400,
                height: 260,
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    color: Colors.grey,

                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: !_isSuccess
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 10,
                          children: [
                            Align(
                              alignment: AlignmentGeometry.centerLeft,
                              child: Text(
                                '로그인',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Divider(height: 2),
                            TextField(
                              controller: idController,
                              focusNode: idFocus,
                              keyboardType: TextInputType.text,
                              // onTap: () {
                              //   if(_isError) idController.text='';

                              // },
                              decoration: InputDecoration(
                                labelText: 'Id를 입력하세요',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            TextField(
                              controller: pwController,
                              focusNode: pwFocus,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Pw를 입력하세요',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    0,
                                    0,
                                    0,
                                  ),
                                  foregroundColor: Colors.white,
                                ),

                                onPressed: () => checkLogin(),
                                child: Text('Log in'),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Text('======= Already Login. ======'),
                          Text('${idController.text}'),
                          ElevatedButton(
                            onPressed: () => logout(),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
              ),
            ),
            Text('Generic isLogin => ${MyGeneric.isLogin}'),
            Text('Generic user => ${MyGeneric.user.toString()}'),
            ElevatedButton(
              onPressed: () => Get.toNamed('/tab'),
              child: Text('Go to Tab Page without arguments'),
            ),
          ],
        ),
      ),
    );
  }

  // == functions
  checkLogin() {
    //
    if (idController.text.trim().isEmpty || pwController.text.trim().isEmpty) {
      // Warn : SnackBar 처리
      idController.text.trim().isEmpty
          ? idFocus.requestFocus()
          : pwFocus.requestFocus();
      Get.snackbar(
        'Wanirng',
        'ID/PW를 입력해 주세요.(빈)',
        backgroundColor: Colors.blue[500],
      );
    } else {
      String id = idController.text.trim().replaceAll(' ', '');
      String pw = pwController.text.trim().replaceAll(' ', '');

      if (id.length < 3 && pw.length < 3) {
        id.length < 3 ? idFocus.requestFocus() : pwFocus.requestFocus();
        Get.snackbar(
          'Wanirng',
          'ID/PW를 확인해 주세요.(길이)',
          backgroundColor: Colors.red[300],
        );
        return;
      }
      bool isIdFail = RegExp(r'[#$%^&*(),.?":{}|<>]').hasMatch(id);
      bool isPwFail = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pw);
      if (isIdFail || isPwFail) {
        isIdFail ? idFocus.requestFocus() : pwFocus.requestFocus();

        Get.snackbar(
          'Wanirng',
          'ID/PW를 확인해 주세요.(스페셜 캐릭터)',
          backgroundColor: Colors.red[300],
        );
        return;
      }

      print('1111=====');
      if (id == 'root' && pw == '1234') {
        // 정상적인 Alert출력
        Get.defaultDialog(
          title: '로그인',
          barrierDismissible: false,
          backgroundColor: Colors.grey[100],
          content: Container(
            height: 100,

            child: Column(children: [Text('정상적으로 처리 됬습니다.')]),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => loginConfirm(id),
              child: Text('확인'),
            ),
          ],
        );
      } else {
        // Warn: SnackBar로 처리
        idFocus.requestFocus();
        Get.snackbar(
          'Wanirng',
          'ID/PW를 확인해 주세요.',
          backgroundColor: Colors.amber[400],
        );
      }
    }
  }

  loginConfirm(String id) async {
    

    Get.back();
    _isSuccess = true;
    MyGeneric.isLogin = _isSuccess;
    MyGeneric.user = User(id:id,smallImage:'images/cat.png');
    // 기다리다 받는 결과값.
    var result = await Get.toNamed(
      '/tab',
      arguments: {'isSuccess': _isSuccess, 'id': id},
    );
    print('================');
    print(result.toString());
    print('================');
    if (result['isSuccess']) {
      // 성공 return
      print('success====================');
    } else {
      // 실패 return
      _isSuccess = false;
      idController.clear();
      pwController.clear();
      
    }
    MyGeneric.isLogin = _isSuccess;
    setState(() {});
  }

  logout() {
    _isSuccess = false;
    MyGeneric.isLogin = _isSuccess;
    MyGeneric.user = null;
    idController.clear();
    pwController.clear();
    setState(() {});
  }
}
