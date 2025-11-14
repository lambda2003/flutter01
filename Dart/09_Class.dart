// Class와 데이터를 주고 받는 방법
// 1. Property
// 2. Contructor
// 3. Method


import 'calc1.dart';

main() {
  // Property를 이용하는 방법
  
  // ************** Calc1 ***************/  
  // 선언
  // Property를 이용하는 방법
  // 주의: Class의 속성이 노출됨.
  Calc1 calc1 = Calc1();

  calc1.num1 = 1;
  calc1.num2 = 2;
  print('============= Property ============');
  print(calc1.addtion());


  // 선언
  // Methods를 이용하는 방법
  // 선언 후 메소드를 사용할때 params들을 넘겨줌
  print('============= Method ============');
  Calc2 calc2 = Calc2();
  print("덧셈 결과 : ${calc2.addtion(1, 2)}");
  print("뺄셈 결과 : ${calc2.substraction(1, 2)}");
  print("곱셈 결과 : ${calc2.multiplication(1, 2)}");
  print("나눗셈 결과 : ${calc2.division(1, 2)}");
  
  // 선언
  // Constructor를 이용하는 방법
  // 생성할때 params를 넘겨줌
  // 생성자의 property에 "_"를 쓰면 private 의미임. 
  //  -- 속성이 노출 안됨. 
  Calc3 calc3 = Calc3(1,2);
  print('============= Constructor(with private _) ============');
  print('=== 클래스의 _num1, _num2는 private이라 access가 안됨.');
  // print('${calc3._num1} ${calc3._num2}'); // ERROR
  print('public property access: Calc3.publicProperty = ${calc3.publicProperty}');
  print('=== 클래스의 publicProperty는 public이라 access가 안됨.');
  print("덧셈 결과 : ${calc3.addtion()}");
  print("뺄셈 결과 : ${calc3.substraction()}");
  print("곱셈 결과 : ${calc3.multiplication()}");
  print("나눗셈 결과 : ${calc3.division()}");


  // NullSafe 및 생성자 Map변수 넘김. 
  /*
    class Calc4 {
      // Property
      int? _num1;
      int? _num2;

      Calc4({int? num1, int? num2}) {
        this._num1 = num1;
        this._num2 = num2;
      }
      ....
    }
  */
  Calc4 calc4 = Calc4(num1: 1, num2: 2);
  print("덧셈 결과 4: ${calc4.addtion()}");

}