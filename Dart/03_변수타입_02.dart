

main() {

 
  // List<Map<String,dynamic>> listObject = [{"title":"a","balance":10.11},{"title":"b","balance":11.11},{"title":"c","balance":12.11}];
  // for(var d in listObject){
    
  //   // print(d.runtimeType);
  //   print(d["title"]+" -- "+d["balance"].toString());
  // }
  // listObject.forEach((d){
  //   print(d['title']);
  // });



  // String str1 = "유비";
  // String str2 = '장비';

  // print(str1 + " : " + str2);

  // print("$str1 : $str2");

  // int intNum1 = 170;
  // int intNum2 = 70;
  
  // print("두 수의 합계는 intNum1 + intNum2 = ${intNum1+intNum2} 입니다");


  // var name = 1;
  // // name = 1;
  // dynamic name1 = 'bb';
  // name1 = 1;
  // print(name+name1);
  Car c = Truck("코란도","쌍용");
  c.info();
  print(c.runtimeType);
}

abstract class Car {
  String name = '';
  String company = '';
  info() {}
}

class Truck extends Car {
  Truck(String name, String company) {
    this.name = name;
    this.company = company;
  }
  info() {
    print("name: ${this.name} - company: ${this.company}");
  }
}

