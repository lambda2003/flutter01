
main() {
  // Function : Code의 집합이다.
  // ---- Function
  // List<int> list1 = [1,3,5,7,9];
  // // List<int> list2 = [10,30,50,70,90];
  // // List<int> list3 = [10,30];

  // int addList(List<int> fList){
  //   int sum = 0;
    
  //   for(int i in fList){
  //     sum += i;
  //   }
  //   return sum;
  // }

  // int result = addList(list1);
  // print("합계 = $result");

  // // print(addList(list1));
  // // print(addList(list2));
  // // print(addList(list3));

  // T addFunction<T>(T a, T b) {
  //   print(T);

  //   return a;
          

  // }
  // int subFunction(int a, int b) {
  //   return a-b;
  // }
  // int mulFunction(int a, int b){
  //   return a*b;
  // }
  // double divFunction(int a, int b){
  //   if(b == 0) {
  //     return 0;
  //   }
  //   return a/b;
  // }

  // // Tuple Return  (ReadOnly)
  // calcFunction(int num1, int num2){
  //   return (num1+num2, num1-num2, num1*num2,num2>0?num1/num2:0);
  // }
  // print(calcFunction(2, 3));


  // print(addFunction(2,3));
  // print(subFunction(2,3));
  // print(mulFunction(2,3));
  // print(divFunction(2,3));


  // [34,32,55,57,59,53,90,88,88,12]
  List<int> inputValue = [34,32,55,57,59,53,90,88,88,12];
  Map<int,String> data = {90: '', 80: '', 70: '', 60: '', 50:'' , 40:'' , 30:'' , 20: '', 10:''};

  // for(int v in inputValue){
  for(int v in inputValue){
    int key = (v~/10*10).toInt();
    data[key] = "${data[key]}#";
    // print(key); 
  }
  print(data);

    //   for(var d in data.entries){
  //     int key = d.key;
  //     String value = d.value;
  //     if(v~/key==1 && v%key<10) {
  //       print(v/key);
  //       data[key] = "${data[key]}#";
  //       break;
  //       // data[key] = "${data[key]}#"
  //     }
  //   }
  // }
  // print(data);
    
  
  // print(data);

  // List<Map<String,dynamic>> listMap1 = [];
  // listMap1.addAll([
  //   {"id":1,"title":"상품 1의 타이틀","description":"하하하하 상품"},
  //   {"id":2,"title":"상품 2의 타이틀","description":"호호호호 상품"},
  //   {"id":3,"title":"상품 3의 타이틀","description":"캬캬캬캬 상품"},
  // ]);

  // void getAll(String kwd,List<Map<String,dynamic>> fList) {
    
  //   for(var data in fList) {
  //     String title = data["title"];
  //     var m = RegExpMatch();
  //   }
  // }
  // getAll('test',listMap1);

}
