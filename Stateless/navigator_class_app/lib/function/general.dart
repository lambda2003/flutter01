
import 'package:flutter/material.dart';

void removeContext(context) {
  int safeIndex = 1;
  while(true) {
    if(safeIndex>10) break;
    if(Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }else {
      break;
    }
    safeIndex++;
  }
}


