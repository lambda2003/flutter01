import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gt_test_app/model/auth.dart';
import 'package:gt_test_app/model/item.dart';
import 'package:gt_test_app/vm/auth_notifier.dart';
import 'package:gt_test_app/vm/item_notifier.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
  // State<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    final items = ref.watch(itemProvider);
    // final auth = ref.watch(authNotiProvider);
  
    print('==== home build ====');

    return Scaffold(
      appBar: AppBar(title: Text('111')),
      body: Center(
        child: Column(
          children: [
            Text('assss'),

             Container(
              color:Colors.green,
              width: 400,
              height: 500,
               child: SingleChildScrollView(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: items.when(
                    data: (data) =>
                        List.generate(data.length, (index) => Text(data[index].title)),
                    loading: () => [const CircularProgressIndicator()],

                    error: (error, stackTrace) {
                      return [Text('${error.toString()}')];
                    },
                  ),
                         ),
               ),
             ),
            switch (items) {
              AsyncData(:final value) => Text('data: ${value!.length}'),
              AsyncError(:final error) => Text('error: $error'),
              AsyncLoading() => Text('AsyncLoading===='),
              _ => const Text('loading')

            },

             ElevatedButton(onPressed: (){
              ref.read(itemProvider.notifier).loadingMore();
              // state이 변경되면 다시 리빌드

             }, child: Text('More')),
                   ElevatedButton(onPressed: (){
            //  ref.read(itemProvider.notifier).refresh();
            ref.refresh(itemProvider);
              // state이 변경되면 다시 리빌드

             }, child: Text('refresh')),
          
               Text(items.isLoading.toString()),  // at first time loading (Only True)
                Text(items.isRefreshing.toString()),
                Text(items.isReloading.toString()), // loading and reloading
            // Text(ref.read(authProvider.notifier).currentState!.authState.toString()),
            // Text(ref.read(authNotiProvider).authState.toString()),
            // SizedBox(
            //   child: Column(
            //     children: auth.when(
            //       data: (data) => [
            //         Text(data.authState.toString()),
                
            //         // 업데이트가 안된다.
            //         // Text(ref.read(authNotiProvider.notifier).errMsg.toString()),
            //       ],
            //       loading: () => [const CircularProgressIndicator()],

            //       error: (error, stackTrace) {
            //         return [Text('${error.toString()}')];
            //       },
            //     ),
            //   ),
            // ),
                // Text(auth.value!.user != null ? auth.value!.user!.name : 'empty'),
                // Text(auth.isLoading.toString()),
                // Text(auth.isRefreshing.toString()),
                // Text(auth.isReloading.toString()),
                                     
            // ElevatedButton(
            //   onPressed: () {
            //     if (auth.value!.authState == AuthType.authoirzed) {
            //       ref.read(authNotiProvider.notifier).logout();
           
            //     } else {
            //       ref.read(authNotiProvider.notifier).login();
            //     }

            //     // state이 변경되면 다시 리빌드
            //   },
            //   child: Text('aa'
            //     // '${auth.value!.authState == AuthType.authoirzed ? "logout" : "login"}',
            //   ),
            // ),
          ],
        ),
      ),
    );

    // Functions
  }
}

// // final counterProvider = StateProvider((ref) => 0);
// final userProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   return await UserService().fetchUser('');
// });

// class User {
//   final String name;
//   const User({required this.name});
// }

// class UserService {
//   // 요청 변수를 받는다
//   // 조건문에 들어 갈 것들.
//   Future<List<User>> fetchUser(String? order) async {
//     await Future.delayed(Duration(seconds: 2));

//     List<User> users = [
//       User(name: 'A'),
//       User(name: 'B'),
//       User(name: 'C'),
//       User(name: 'D'),
//     ];

//     return users;
//   }
// }
