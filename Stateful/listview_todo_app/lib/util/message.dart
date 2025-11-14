
// 보관장소
import 'package:listview_todo_app/model/todo_list.dart';

class Message{
  // Property
  static String workList = '';

  // Constructor

  // Methods


}
 
// Repository
class ItemRepository<T>{
  
  static List items = [
    TodoList.fromJson({'imagePath': 'images/cart.png', 'workList': '책구매'}),
    TodoList.fromJson({
        'imagePath': 'images/pencil.png',
        'workList': '철수와 약속',
      }),
    TodoList.fromJson({
        'imagePath': 'images/pencil.png',
        'workList': '스터디 준비하기',
      }),
  ];

  addItems(T v) {
    items.add(v);
  }
}