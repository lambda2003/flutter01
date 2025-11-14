import 'dart:collection';
import 'dart:ffi';

main() {
  // List<Person> ps = [];
  // ps.addAll([Person('지훈', 20), Person('동훈', 33)]);

  // for (final person in ps) {
  //   print(person.name);
  // }
  // ps = [];

  // final testMap = {
  //   "a": {"title": "title 1"},
  //   "b": {"title": "title 2"},
  //   "c": {"title": "title 3"},
  // };
  // final Map<String,dynamic> testMap = {"a": {"title":"title 1"}, "b": {"title":"title 2"}, "c": {"title":"title 3"}};
  //  for (final mapEntry in testMap.entries) {
  //   final key = mapEntry.key;
  //   final value = mapEntry.value;

  //   print('Key: ${key}(${key.runtimeType}), Value: $value');
  // }

  // List<Item> items = [];
  // items.addAll([
  //   Item("title 1",5,1000.0),
  //   Item("title 2",1,1200.0),
  //   Item("title 3",3,1000000.0),
    
  // ]);
  // for(Item item in items){
  //   print(item.title);
  // }


  // // 1 ~ 10 까지 합계를 구하는 중 숫자가 5를 만난경우에는 합께 계산 중단.
  // int sum = 0;  // 합계
  // int number = 1;    // index

  // while(true){
  //   if(number == 5) break;
  //   sum += number;
  //   number++;
  // }
  // print("While loop 총합 = $sum");

  // sum = 0;
  // for(int number=1;number<=10;number++){
  //   if(number == 5) break;
  //   sum += number;
  // }
  // print("For loop 총합 = $sum");



  // // 구구단 중 5단을 출력
  final listNumber = {};
  // // int dan = 5;
  // // for(int i = 1; i<=9;i++){
  // //   print("$dan x $i = ${i*dan}");
  // // }
 

  // for(int dan = 2; dan <=9; dan++){
  //   listNumber[dan.toString()] = [];
  //   for(int i=1;i<=9;i++){
  //     listNumber[dan.toString()].add(i*dan);
  //   }
  // }
  // print(listNumber);

  // 전체 구구단 중에 짝수단과 짝수 곱해지는 수만 출력
  // for(int dan = 2;dan<10;dan++){
  //   if(dan%2 == 0){
  //     print('=== Dan: $dan');
  //     for(int i=1;i<10;i++){
  //         print("$dan x $i = ${dan*i}");
  //     }
  //   }else continue;
  //   print("$dan =====");
  // }


  // 구구단 출력중 단: 2,3,6,7 /// 곱해지는 수는 1,2,6,9
  // for(int d in [2,3,6,7]){
  //   print("======= $d 단 =======");
  //   // listNumber[d.toString()] = [];
  //   for(int n in [1,2,6,9]){
  //     print("$d x $n = ${d*n}");
  //     // listNumber[d.toString()].add("$d x $n = ${d*n}");
  //   }
  // }
  // print(listNumber);
  
  // List<Map<String,String>> list_dic = [
  //   {
  //     'apple' : '사과',
  //     'banana': '바나나'
  //   },
  //   {
  //     'James' : '제임스',
  //     'Smith' : '스미스',
  //   }

  // ];

  // for(var d in list_dic){
  //   print(d['apple']);
  // }

  Map<String,List<String>> dic_list = {
    "schools" : ['a','b','c'],
    "names" : ['james','cathy','cooper'],
  };

  for(var mapData in dic_list.entries){
    String key = mapData.key;
    List<String> values = mapData.value;
    
    print("=== key => '$key' ====");
    
    for(var d in values) {
      print("data => '$d'");
    }
  
  }

}

class Item {
  String? title;
  int quantity = 0;
  double price = 0.0;

  // Required variables
  Item(title,quantity,price){
    this.title= title;
    this.quantity = quantity;
    this.price = price;
  }
}



class Person {
  String? name;
  int age = 0;
  Person(name, age) {
    this.name = name;
    this.age = age;
    print('==Contructor==');
  }

  setName(name) {
    this.name = name;
  }

  setAge(age) {
    this.age = age;
  }
}
