import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gt_test_app/model/user.dart';
import 'package:gt_test_app/util/api_client.dart';





class AuthRepository {

  final apiProvider;

  AuthRepository({required this.apiProvider}){
    print('== Class AuthRepository Build ==');
  }

  Future<User> login() async {
    // api와 연결해서 가져온다
    
    // await Future.delayed(Duration(seconds: 1));
    final user = await apiProvider.authRequest('/login',null);
    
    return user;
  }
  
  Future<User?> logout() async {
    // api와 연결해서 가져온다
    
    // await Future.delayed(Duration(seconds: 1));
    final user = await apiProvider.authRequest('/logout',null);
    
    return user;
  }
  // Future<Auth> logout() async{
  //   return Auth(authState: AuthType.init,user: null);
  // }

}

final authRepositoryProvider = Provider((ref){
    print('==== Provider: AuthRepoProvider Created =====');
    final p = ref.read(apiClientProvider);
    return AuthRepository(apiProvider: p);
});