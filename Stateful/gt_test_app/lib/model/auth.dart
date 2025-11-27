
import 'package:gt_test_app/model/user.dart';

enum AuthType {
  init,
  loading,
  authoirzed,
  fail,
}

class Auth{
  AuthType authState;
  User? user;
  String? errMsg;

  Auth({this.user, required this.authState,this.errMsg}){
    print('=== Class Auth Instance Created ==');
  }

  Auth copyWith({AuthType? authState, User? user}) {
    return Auth(
      authState: authState ?? this.authState,
      user: user ?? this.user,
    );
  }
}

// final authProvider = Provider((ref){
//   return Auth(authState: AuthType.init);
// });
