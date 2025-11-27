import 'package:flutter/material.dart';
import 'package:gt_test_app/model/item.dart';
import 'package:gt_test_app/util/api_client.dart';
import 'package:riverpod/riverpod.dart';

class ItemRepository {
 final String apiClient;

 ItemRepository({required this.apiClient});



  Future<List<Item>> fetch(int page, int limit) async {
    await Future.delayed(Duration(seconds: 4));
    // return [Item(id:0,title:'')];
    print('=========================Called');
    return List.generate(limit, (index)=>Item(id:index+(page*limit),title:'title-${index+(page*limit)}'));

  } 



}

final itemRepositoryProvider = Provider((ref) {
  // API Client를 여기서 가져와서 넘겨줌
  // ex: ref.watch(ApiClient)
  return ItemRepository(apiClient: 'apiclient');
});