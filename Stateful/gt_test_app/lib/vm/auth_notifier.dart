

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gt_test_app/model/auth.dart';
import 'package:gt_test_app/repository/auth_repository.dart';

class AuthNotifier extends AsyncNotifier<Auth>{

  // late final AuthRepository repository;
  late AuthRepository repository;


  // bool get isRefreshing =>
  //     isLoading && (hasValue || hasError) && this is! AsyncLoading;


  @override
  FutureOr<Auth> build() {
    // TODO: implement build
    // check current state
    print('==== Auth Notifier Build ===');
    // return Auth(authState: AuthType.init);
    return Future.delayed(Duration(seconds: 2),()=>Auth(authState: AuthType.init));
  }
  
  Future<void> login() async {
    try {
     
      if(state.value!.authState != AuthType.authoirzed){
        // 이미 로그인 된것들은 아무것도 하지 않는다. 
      
        state.whenData((data) {
          state = AsyncData(data.copyWith(authState: AuthType.loading));
        });
        //AsyncValue.data(Auth(authState: AuthType.loading));
   
    
        final user = await ref.read(authRepositoryProvider).login();
        await Future.delayed(Duration(seconds: 1));
        
        state.whenData((data) {
          state = AsyncData(data.copyWith(authState: AuthType.authoirzed, user: user));
        });

        // state = AsyncValue.data(Auth(authState: AuthType.authoirzed, user: user));

        // state = await AsyncValue.guard(() async {
        //   final user = await repository.login();
        //  return Auth(authState: AuthType)
        // });
      }
    }catch(e){
      // TODO: ERROR REPORT
      print(e.toString());
    }
  }

  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    // state = AsyncValue.data(Auth(authState: AuthType.init));
    final user = await ref.read(authRepositoryProvider).logout();
  
    state = AsyncData(Auth(authState: AuthType.init, user: user));
    }

  




}

final authNotiProvider = AsyncNotifierProvider<AuthNotifier,Auth>((){
  print('==== provider authNotiProvider created ===');
  return AuthNotifier();
});