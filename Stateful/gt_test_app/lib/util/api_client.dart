

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gt_test_app/model/user.dart';

class ApiClient{

  int limit = 5;

  // Future<T> request(String page, Map<String,dynamic> data) async{
  //   await Future.delayed(Duration(seconds: 1));
    
  //   List.generate(5, (index)=>
  //   User(id: id, name: name))
    
  // }
  Future<User?> authRequest(String page, Map<String,dynamic>? data) async{
    await Future.delayed(Duration(seconds: 4));
    if(page == '/logout'){
      return null;
    }
    return User(id: 1, name: '하하하하 로그인 유저');
  }
}

final apiClientProvider = Provider((ref){
  return ApiClient();
});
