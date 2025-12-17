import 'package:flutter/material.dart';


class ColorConvert {
  Color parseColor(String colorString){
    Color baseColor = Colors.white;
    switch (colorString){
      case "Colors.amber":
        baseColor = Colors.amber;
      case "Colors.yellow":
        baseColor = Colors.yellow;
      case "Colors.green":
        baseColor = Colors.green;
      default:
        baseColor = Colors.black;
    }
    return baseColor;
  }

}