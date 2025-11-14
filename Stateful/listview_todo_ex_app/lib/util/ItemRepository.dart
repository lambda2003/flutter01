// import 'package:listview_todo_ex_app/model/TodoList.dart';

class ItemRepository<T>{
  
  static List items = [];

  addItems(T v) {
    items.add(v);
  }

  removeItemByObject(T v) {
    items.remove(v);
  }
  removeItemByIndex(int index) {
    items.removeAt(index);
  }

  updateItemByIndex(int index,T obj) {
    // if(items.length-1 == index){
      items[index] = obj;
  }
  //     return true;
  //   }
  //   return false;
  // }

}