import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gt_test_app/model/item.dart';
import 'package:gt_test_app/repository/item_repository.dart';

// class ItemNotifier extends Notifier<List<Item>>{

//   ItemRepository itemRepo = ItemRepository(apiClient: 'ccc');
//   bool isLoading = false;

//  @override
//   List<Item> build() {
//     // TODO: implement build
//     return [];
//   }

//   Future<void> get(int page, int limit) async{

//     state = await itemRepo.fetch(page, limit);

//   }
// }

// final itemProvider = NotifierProvider<ItemNotifier, List<Item>>(
//   () {
//     return ItemNotifier();
//   },
// );

class ItemNotifier extends AsyncNotifier<List<Item>> {
  // final itemRepo;// ItemRepository(apiClient: 'ccc');
  // bool isLoading = false;
  int page = 0;
  final int limit = 5;

  ItemNotifier();

  @override
  FutureOr<List<Item>> build() async {
    // TODO: implement build
    return ref.read(itemRepositoryProvider).fetch(page, limit);
  }
  // bool get isRefreshing =>
  //     isLoading && (hasValue || hasError) && this is! AsyncLoading;
   Future<void> refresh() async {

    // state = await AsyncValue.guard(() async {
    //   final repository = ref.read(itemRepositoryProvider);
    //   // After adding, re-fetch the updated list
    //   final newData = await repository.fetch(page, limit);
    //   return newData;
    // });
    state = await AsyncValue.guard(() async {
      final repository = ref.read(itemRepositoryProvider);
      
      // After adding, re-fetch the updated list
      final newData = await repository.fetch(page, 6);
      return newData;
    });

   }
  Future<void> loadingMore() async {
    // AsyncValue<List<Item>> myAsyncList = AsyncValue.data();
    final previousState = state.value;
    
    // state = const AsyncValue.loading();
    // state = ref.read(itemRepositoryProvider).fetch(page, limit) as AsyncValue<List<Item>>;
    state = await AsyncValue.guard(() async {
      final repository = ref.read(itemRepositoryProvider);
      page++;
      // After adding, re-fetch the updated list
      final newData = await repository.fetch(page, limit);
      return [...previousState!, ...newData];
    });
  }
}

final itemProvider = AsyncNotifierProvider<ItemNotifier, List<Item>>(() {
  return ItemNotifier();
});
