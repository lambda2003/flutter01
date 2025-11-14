import 'dart:ffi';
import 'dart:math';
main() {
  // Factorial 구하기
  // 4! = 4*3*2*1;

  // int factorial = 3;
  // int sum = 1;
  // for (int i = factorial; i > 0; i--) {
  //   // 4! = 1*2*3 = (1*2)*3
  //   sum = sum * i;
  // }
  // print("$factorial! = $sum");




  // BMI
  // 신장이 170cm이고 몸무게 70Kg BMI 계산하기

  // 0 - 18.4 : 저체중
  // 18.5 - 22.9 정상
  // 23 - 24.9 과체중
  // 25-29.9 비반
  // 30이상 고도비만

  // // List를 이용해서 5보다 작은 숫자만 List에 넣기
  // // 입력숫자 : 1,1,22,3,5,8,13,21,34,55,89
  // // 결과 [1,2,3,4]
  // List<int> dataSet = [99, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
  // List<int> result = [for (int d in dataSet) if (d < 5) d];
  // print(result);


  // List의 최대값과 최대값의 위치 구하기
  // 입력 : [11,12,13,14,15]

  // List<int> dataSet = [11,12,15,14,11];
  
  // int maxNum = 0;
  // int maxIndex = 0;
  // int index = 0;
  // // for(int value in dataSet){
  // //   if(value>maxNum) {
  // //     maxNum=value;
  // //     maxIndex = index;
  // //   }
  // //   print("index => $index");
  // //   index++;
  // // }
  // maxNum = dataSet[0];
  // for(int index=0;index<dataSet.length;index++){
  //   if(dataSet[index]>maxNum){
  //     maxNum = dataSet[index];
  //     maxIndex = index+1;
  //   }
  // }
  // print("숫자들중 최대값은 $maxNum이고 ${maxIndex}번째 값 입니다.");



  // // 입력한 숫자의 한 자릿수 정수의 합 구하기
  // int inputValue = 12345678;
  // int max = pow(10,inputValue.toString().length-1).toInt();
  // int xSum = 0; //36;
  // while(max>0){
  //     xSum += inputValue~/max; 
  //     inputValue = (inputValue%max);
  //     max = (max/10).toInt();
  // }
  // print(xSum);

  // int inputValue = 12345678;
  // int calcValue = inputValue;
  // int reminder = 0;
  // int sumx = 0;

  // while(calcValue>0) {
  //   reminder = calcValue % 10;
  //   print("reminder=> $reminder ($calcValue/10)");
  //   // r = 2345678
  //   // r = 1
  //   sumx = sumx + reminder;
   
  //   // s = 2345678
  //   calcValue = calcValue ~/ 10; 
  //   print("$calcValue = $calcValue ~/ 10");
  //   // c= 1234567
  // }
  // print(sumx);
 

  



 
  // max = 0;
  // dataSet.forEach((d)=>d>max? {max=d;} : null
      
    
  // ); 


  // print("숫자들중 최대값은 $max이고 $maxIndex번째 값 입니다.");





  // final List<Map<String, int>> data = [
  //   {"height": 170, "weight": 70},
  //   {"height": 190, "weight": 70},
  // ];
  // final List<Map<double, dynamic>> bmiTable = [
  //   {18.4:'aa'},
  //   {22.9:'bb'},
  //   {24.9:'cc'},
  //   {29.9:'dd'},
  //   {100: '고도비만'}
  // ];

  // while (true) {
  //   if (data.length == 0) break;

  //   var d = data.removeLast();
  //   print(d);
  //   d.map((key,value)=>key>);

 
  // }
  // print(data);










  // int tall = 170; //cm
  // double tallMeter = tall/100; // meter

  // int weight = 70; // Kg

  // // BMI 공식
  // double bmi = weight/(tallMeter*tallMeter);
  // print(bmi);
  // String result = '';
  // while(true){

  //   if(bmi<18.4){
  //     print('저체중');
  //     break;
  //   }else if(bmi<22.9) {
  //     print('정상');
  //     break;
  //   }else if(bmi<24.9){
  //     print('과체중');
  //     break;
  //   }else if(bmi<29.9){
  //       print('비만');
  //     break;
  //   }else{
  //     print('고도비만');
  //     break;
  //   }

  // }
  // for(var tableItem in bmiTable){
  //   int index = 0;
  //   int selectedIndex = 0;
  //   for(var entryMap in tableItem.entries){
  //     double key = entryMap.key;
  //     String value = entryMap.value;
  //     if(bmi<key){
  //       selectedIndex = index;
  //     }

  //   }
  //   index++;

  // }
}
