main() {
  // // Collections -
  // // 1: List Collection
  // int num1 = 1;
  // List threeKingdoms = [];

  // // List에 데이터 추가하기
  // threeKingdoms.add('위');
  // threeKingdoms.add('촉');
  // threeKingdoms.add('오');

  // print(threeKingdoms);

  // // 원하는 데이터만 출력하기
  // // print(threeKingdoms[0]);
  // // 변경하기
  // // threeKingdoms[0] = '대한민국';
  // // print(threeKingdoms);

  // // // 삭제 하기
  // // threeKingdoms.removeAt(1);
  // // threeKingdoms.remove('대한민국');
  // // print(threeKingdoms);

  // // ReplaceRage
  // // threeKingdoms.replaceRange(1, 3, ['카카오','네이버']);
  // // print(threeKingdoms);

  // // removeWhere
  // threeKingdoms.removeWhere((d) => d=='촉');
  // print(threeKingdoms);

  // List<String> threeKingdoms2 = [];
  // threeKingdoms2.add('We');
  // threeKingdoms2.add('촉');
  // threeKingdoms2.add('오');

  // threeKingdoms2.map((d)=>{
  //   if(d == 'We') {d = "위"}
  // });

  // // threeKingdoms2[0] = 'We';
  // print(threeKingdoms2);

  // // 정해진 길이의 LIST만들기
  // // 추가/삭제(add,remove) 는 안됨. 수정 가능
  // var threeKingdoms3 = List<String>.filled(3,"");
  // threeKingdoms3[0] = "We";
  // // threeKingdoms3.removeAt(0); // ERROR
  // print(threeKingdoms3);

  // List<String> threeKingdoms4 = ['위','촉','오'];
  // print("${threeKingdoms4[0]} 나라가 삼국을 통일 했습니다.");

  // print(threeKingdoms4.contains((d)=>d=='위'));

  // Map<String,String> fruits = {
  //   'apple':'사과',
  //   'grape' : '포도',
  //   'watermelon' : '수박'
  // };

  // print(fruits);

  // // 해당 key 데이터 가져오기
  // print(fruits['apple']);

  // // 해당 key 데이터 수정
  // fruits['watermelon'] = '시원한 수박';
  // print(fruits);

  // // 데이터 추가
  // fruits['banana'] = '바나나';
  // print(fruits);

  // Map carMakers = {};
  // carMakers.addAll({
  //   'hyundai': '현대자동차',
  //   'kia' : '기아자동차'
  // });
  // print(carMakers);

  // /*** MAP관련 */

  // // Map의 key만 따로 출력하기
  // // tuple (read only list) -> 소가로 (hyundai,kia)
  // print(carMakers.keys.toString()); // tuple
  // print(carMakers.keys.toList()); // List

  // // Map의 value만 따로 list로 생성하기
  // var carMakersKoreaNames =  carMakers.values.toList();
  // print(carMakersKoreaNames);

  // // Generic을 선언하여 map 구성하기
  // Map<String, int> fruitsPrice = {
  //   'apple' : 1000,
  //   'grape' : 2000,
  //   'watermelon' : 3000
  // };
  // print(fruitsPrice['apple']);
  // // int가 null값이면 에러가 나오기 때문에 int? 식으로 써야 함.
  // // int applePrice = fruitsPrice['apple']; // error
  //   int applePrice = fruitsPrice['apple']!; // 끝에 !는 apple값이 존재 하니 무시하고 실행 하라는 의미
  // print("사과의 가격은 $applePrice원입니다.");

  // // apple 과 grapde의 합계를 출력하시오
  // print("apple 과 grapde의 합계 = ${(fruitsPrice['apple']!+fruitsPrice['grape']!)}원 입니다.");

  // // 연산자
  // // 자동 증감 연산자
  // int num = 0;
  // num++;
  // num--;
  // print(num);

  // // Optional : Null Safty
  // // int num1 = null; // Error
  // int? num1 = null;
  // num1 ??= 10; // null일경우 default value 정의
  // // num1==null?num1=10:num1=0;
  // print(num1);

  // // // Dead code: num1=100으로 할당 되어 있기때문에 dead code.
  // // int? num1 = 100;
  // // num1 ??= 10; // null일경우 default value 정의
  // // print(num1);

  // // 단항 증감 연산자
  // int num2 = 20;
  // num2 += 10;
  // print(num2);

  // // 조건 연산자
  // int num3 = 10;  // ....
  // int num4 = 5;   // ....
  // print(num3 < num4);
  // print(num3 > num4);
  // print(num3 == num4);
  // print(num3 <= num4);
  // print(num3 >= num4);
  // print(num3 is int);
  // print(num3 is String);
  // print(num3 is ! double);

  // // 조건문(판단문)
  // int num1 = 5;
  // if(num1 > 10){
  //   print('입력된 숫자 $num1은 10보다 큰 수 입니다.');
  // }else{
  //   print('입력된 숫자 $num1은 10보다 작거나 같은 수 입니다.');
  // }
  // print('---------- END ----------');

  // Exerise
  // 변수에 있는 숫자값을 비교해서
  // 숫자가 5의 배수 이면 : 입력된 숫자가 __는 5의 배수입니다.
  // 아니면 : 입력된 숫자 __는 5의 배수가 아니면 나머지 값은 __입니다.

  int num3 = 15;
  // int r = num3%5;
  // if(r == 0) {
  //   print("입력된 숫자가 $num3는 5의 배수입니다.");
  // }else{
  //   print(" 입력된 숫자 $num3는 5의 배수가 아니며 나머지 값은 $r입니다.");
  // }
  // print('---------- END ----------');

  // List<int> listNum = [10,14,15];
  // for(int d in listNum){
  //   int r = d%5;
  //   if(r == 0) {
  //     print("입력된 숫자 $d는 5의 배수입니다.");
  //   }else{
  //     print("입력된 숫자 $d는 5의 배수가 아니며, 나머지 값은 $r입니다.");
  //   }
  // }

  // // Switch는 if문보다 50배 빠름!!!!
  // switch(num3%5) {
  //   case 0:
  //     print("입력된 숫자가 $num3는 5의 배수입니다.");
  //     break;
  //   default:
  //     print(" 입력된 숫자 $num3는 5의 배수가 아니며 나머지 값은 ${num3%5}입니다.");
  // }

  // Exercise
  // num2가 2의 배수 이면 '2의 배수 입니다.'
  // num2가 3의 배수 이면 '2의 배수 입니다.'
  // num2가 5의 배수 이면 '2의 배수 입니다.'
  // num2가 3가지 조건이 아니면 '2,3,5의 배수가 아닙니다.'

  // int num2 = 12;
  // int r2 = num2%2;
  // int r3 = num2%3;
  // int r5 = num2%5;

  // if(r2 == 0) {
  //   print('$num2는 2의 배수 입니다.');
  // }else if(r3 == 0) {
  //   print('$num2는 3의 배수 입니다.');
  // }else if(r5 == 0){
  //   print('$num2는 5의 배수 입니다.');
  // }else{
  //   print('$num2는 2,3,5의 배수가 아닙니다.');
  // }

  // //입력된 점수를 학점으로 표시

  // int score = 76;

  // // if구문
  // if (score >= 90) {
  //   print('A');
  // } else if (score >= 80) {
  //   print('B');
  // } else if (score >= 70) {
  //   print('C');
  // } else if (score >= 60) {
  //   print('D');
  // } else {
  //   print('F');
  // }

  // // Switch로 사용시
  // int d = score ~/ 10;
  // switch (d) {
  //   case 9 || 10:
  //     print('A');
  //     break;
  //   case 8:
  //     print('B');
  //     break;
  //   case 7:
  //     print('C');
  //     break;
  //   case 6:
  //     print('D');
  //     break;
  //   default:
  //     print('F');
  // }

  // // 삼항 연산자
  // bool isTrue = true;
  // var result = isTrue ? 'True' : 'False';

  // score >= 90
  //     ? print('A')
  //     : score >= 80
  //     ? print('B')
  //     : score >= 70
  //     ? print('C')
  //     : score >= 60
  //     ? print('D')
  //     : print('F');


  // int sum = 0;
  // for(int i=1;i<=10;i++){
  //   sum += i;
  // }
  // print(sum);


  // // 1부터 10까지의 수중 짝수의 합과 홀수의 합을 구하기
  // int sum1 = 0;
  // int sum2 = 0;
  // for(int i=1;i<=10;i++){
  //   if(i%2 == 0){
  //     sum1 += i;
  //   }else{
  //     sum2 += i;
  //   }
  // }
  // print("짝수 합=$sum1, 훌수 합=$sum2");


  // // 1부터 1000까지의 수중 5배수의 합과 10의 배수의 합과 50의 배수의 합 구하라.
  // int sum5 = 0;
  // int sum10 = 0;
  // int sum50 = 0;
  // //1 - 1000 까지의 수중 5의 배수 합=100500, 10의 배수의 합=50500, 50배수의 합=10500
  // for(int i=1;i<=1000;i++){


  //   // i%50==0 ? sum50 += i : null;
  //   // i%10==0 ? sum10 += i : null;
  //   // i%5==0  ? sum5 += i : null;
    
  //   sum50 += i%50==0 ? i : 0;
  //   sum10 += i%10==0 ? i : 0;
  //   sum5 += i%5==0 ? i : 0;

  //   // if(i%5 == 0){
  //   //   sum5 += i;
  //   // }
  //   // if(i%10 == 0){
  //   //   sum10 += i;
  //   // }
  //   // if(i%50 == 0){
  //   //   sum50 += i;
  //   // }
  // }
  // print("1 - 1000 까지의 수중 5의 배수 합=$sum5, 10의 배수의 합=$sum10, 50배수의 합=$sum50");



  // for(int i=0;i<10;i++){
  //     if(i==5){
  //       continue;
  //     }
  //     print(i);
  // }





  // List<String> dd = ["A","B","C","D"];

  // List<Map<String,dynamic>> listMapNum = [{"title":"타이틀1","num":1},{"title":"타이틀2","num":2}];

  // int total = 0;
  // for(var v in listMapNum){
  //   if(v["num"] is int){
  //     total += v["num"];
  //   }
  // }
  // print(total);

  // List<Map<String,dynamic>> test = [];
  // test.add({'title':'위','num':1});
  // test.add({'title':'촉','num':2});
  // test.add({'title':'오','num':3});

  // var xx = test.map((rows)=>rows["title"]=='촉');
  // print(xx);

  // for(int i=0;i<threeKingdoms.length; i++){
  //   print(threeKingdoms[i]);
  // }
}


