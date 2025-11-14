


// import 'package:flutter/widgets.dart';

class CalcBmi{
  // Property
  double? doubleWeight;
  double? doubleHeight;

  // Constructor
  CalcBmi() {
    print('==== CalBMI constructor');
  }
  // CalcBmi(String weight, String height){
  //   this.doubleWeight = double.parse(weight);
  //   this.doubleHeight = double.parse(height)/100;
  // }

  // Methods
  setCalcBmi(String weight, String height){
    this.doubleWeight = double.parse(weight);
    this.doubleHeight = double.parse(height)/100;
  }

  calcAction(){
  
    String bmiString = ''; // bmi 분류
    String imageString = ''; // bmi Image
    double bmi = double.parse((doubleWeight!/(doubleHeight! * doubleHeight!)).toStringAsFixed(1));
    if(bmi<18.4){
      bmiString = '저체중';
      imageString = 'underweight.png';
    }else if(bmi>=18.5 && bmi<=22.9){
      bmiString = '정상체중';
      imageString = 'normal.png';
    }else if(bmi>=23 && bmi<=24.9){
      bmiString = '과제중';
      imageString = 'risk.png';
    }else if(bmi>=25 && bmi<=29.9){
      bmiString = '비만';
      imageString = 'overweight.png';
    }else{
      bmiString = '고도비만';
      imageString = 'obese.png';
    }
    return (bmi.toString(), bmiString, imageString);
  }

  

}