import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var isLogin = false.obs;

  login() {
    isLogin = RxBool(true);

  }
  logout(){
    isLogin = RxBool(false);

  }
}