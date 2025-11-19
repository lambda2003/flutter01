import 'package:flutter/material.dart';


class TestController extends ChangeNotifier{
  int _count = 0;
  int get count  => _count;

  inc() {
    _count++;
    notifyListeners();
  }

  dec() {
    if(_count>0){
      _count--;
      notifyListeners();
    }
  }

}