

// abstract class MyAbstract {
//   String name = "";
//   String? getName(){
//     print('Abstract - $name');
//     //
//   }
// }

// class Myfactory {
//   static MyAbstract? _instance = null;

//   static _getInstance() {
//     if(_instance == null){
//       _instance = MyTest();
//     }
//     return _instance;
//   }
// }

// class MyTest extends MyAbstract {
  
//   MyTest(){
//     print('=== MyTest Constructor');
//     super.name = "MyTest";
//   }

// }
// class MyTest2 extends MyAbstract {
//   MyTest2() {
//     super.name = "MyTest2";
//   }
//   // @override
//   // String? getName(){
//   //   return "MyTest";
//   // }
// }
// class MyTest3{
//   // static final MyTest3 instance = MyTest3._internal();

// //  factory MyTest3.fromJson(Map<String, dynamic> json) {
// //     return Book(
// //       title: json['title'],
// //       description: json['description'],
// //     );
// //   }

//   testFunction() {

//   }

//    // factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);
// }


// main() {
//   // MyAbstract t = Myfactory._getInstance();
//   // MyAbstract t1 = Myfactory._getInstance();
//   // MyAbstract t2 = Myfactory._getInstance();
//   // print(t.hashCode);
//   // print(t1.hashCode);
//   // print(t2.hashCode);
//   // MyTest3 t3 = MyTest3();
//   // MyTest3 t3_1 = MyTest3();
  
//   // print(t3.hashCode);
//   // print(t3_1.hashCode);

//   String input = '--';
//   print(input.trim().contains(RegExp(r'(\d+)')));

// }



// class GCalculator extends SimpleCal{
//   static GCalculator instance = GCalculator._internal();
//   factory GCalculator()=>instance;
//   GCalculator._internal();
// }



class SimpleCal {
  static SimpleCal instance = SimpleCal._internal();
  factory SimpleCal()=>instance;
  SimpleCal._internal();

  int plus(int a, int b){
    return a+b;
  }

  int minus(int a, int b){
    return a-b;
  }
  
  int multi(int a, int b){
    return a*b;
  }
  
  double divide(int a, int b){
    return b==0 ? 0 : a/b;
  }

  // List<int> getAll() {
  //   return
  // }
}
main() {
  print(SimpleCal.instance.plus(1,1));
  print(SimpleCal.instance.plus(2,2));
  print(SimpleCal.instance.hashCode);
  print(SimpleCal.instance.hashCode);
  print(SimpleCal.instance.hashCode);

}