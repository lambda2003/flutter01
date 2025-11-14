
import 'package:character_app/page1.dart';
import 'package:character_app/page2.dart';

PageLoad(name) {
  print(name);
  if(name == 'home'){
    return Page1();
  } else {
    return Page2();
  }

}