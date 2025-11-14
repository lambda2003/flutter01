

// 싱글톤 패턴 인데 필요 없을 듯.
class GCalculator extends SimpleCal{
  static GCalculator instance = GCalculator._internal();
  factory GCalculator()=>instance;
  GCalculator._internal();
  
  
}


// 아주 간단한 계산기
class SimpleCal  {

  SimpleCal() {
    print('================Created');
  }

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