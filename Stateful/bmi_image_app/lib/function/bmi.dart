
class BMI{
 
  caculator(double h, int w){
    double height = h / 100;
    int weight = w;
    double bmi = weight / (height * height);
    return bmi;
  }



}