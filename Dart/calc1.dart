class Calc1 {
  // Peroperty
  int num1 = 0;
  int num2 = 0;
  // Contructor
  // Calc1(int num1, int num2) {
  //   this.num1 = num1;
  //   this.num2 = num2;
  // }
  // Method
  int addtion() {
    return num1 + num2;
  }

  int substraction() {
    return num1 - num2;
  }

  int multiplication() {
    return num1 * num2;
  }

  double division() {
    return num1 / num2;
  }
}

// Without Peoperties
class Calc2 {
  // Peroperty

  // Constructor

  // Method
  int addtion(int num1, int num2) {
    return num1 + num2;
  }

  int substraction(int num1, int num2) {
    return num1 - num2;
  }

  int multiplication(int num1, int num2) {
    return num1 * num2;
  }

  double division(int num1, int num2) {
    return num1 / num2;
  }
}

// Constructor
class Calc3 {
  // Peroperty
  // 생성자의 property에 "_"를 쓰면 private 의미임. 
  //  -- 속성이 노출 안됨. 
  int _num1 = 0;
  int _num2 = 0;
  // _가 없기때문에 public property가 됨. 
  int publicProperty = 100;

  // Constructor
  Calc3(int num1, int num2) 
  : this._num1 = num1,
    this._num2 = num2;
  
  // Method
  int addtion() {
    return _num1 + _num2;
  }

  int substraction() {
    return _num1 - _num2;
  }

  int multiplication() {
    return _num1 * _num2;
  }

  double division() {
    return _num1 / _num2;
  }
}

// Contructor
// Private
// NULL SAFE
class Calc4 {
  // Property
  int? _num1;
  int? _num2;

  Calc4({int? num1, int? num2}) {
    this._num1 = num1;
    this._num2 = num2;
  }

   // Method
  int addtion() {
    return _num1! + _num2!;
  }

  int substraction() {
    return _num1! - _num2!;
  }

  int multiplication() {
    return _num1! * _num2!;
  }

  double division() {
    return _num1! / _num2!;
  }
}