main() {
  // 변수타입 선언
  // 정수
  // var는 메노리가 크다.
  int intNum1 = 30;
  int intNum2 = 20;
  print(intNum1 + intNum2);
  print(intNum1 - intNum2);
  print(intNum1 * intNum2);
  print(intNum1 / intNum2);
  print('나머지값=' + (intNum1 % intNum2).toString()); // 나머지값
  print('목값 = ' + (intNum1 ~/ intNum2).toString()); // 몫값

  // 실수
  double dNum1 = 1.5;
  double dNum2 = 0.2;

  print(dNum1 + dNum2);
  print(dNum1 - dNum2);
  print(dNum1 * dNum2);
  print(dNum1 / dNum2);

  print(intNum1 + dNum1); // double로 바뀜.
}
