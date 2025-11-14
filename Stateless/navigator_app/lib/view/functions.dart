import 'package:flutter/material.dart';

void removeContext(BuildContext context) {
  int index = 0;
  while (true) {
    if(index<10) break;
    if (Navigator.canPop(context))
      Navigator.pop(context);
    else
      break;

    index++;
  }
}

void snackBarFunction(
  BuildContext context,
  String buttonType,
  int second,
  Color bacgroundColor,
  String text,
) {

  // 하단에 뜨는 Menu
  // memory와 많이 연관됨
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bacgroundColor,
      duration: Duration(
        seconds: second, //buttonType=="Snackbar"? 1 : 3, // 1초
      ),
      showCloseIcon: true,
      content: Text(text),
    ), // SnackBar Widget (Style)
  );
}
