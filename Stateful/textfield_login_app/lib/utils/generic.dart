

import 'package:textfield_login_app/model/user.dart';

class MyGeneric {

  static bool isLogin = false;
  static User? user; 
}

class ItemRepository<T> {

  List repository = [];

  addItem(T v){
    repository.add(v);
  }
}