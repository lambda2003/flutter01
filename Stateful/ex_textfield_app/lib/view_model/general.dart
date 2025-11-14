
import 'package:flutter/material.dart';

class General {

  static void sendSnackMessage(BuildContext context, String type, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${type.toUpperCase()} : $msg'),
        backgroundColor: type == 'warn'
            ? Colors.orange
            : type == 'error'
            ? Colors.red
            : Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void reset(List<TextEditingController> controllers) {
    for(TextEditingController d in controllers) {
      d.clear();
    }
  }


  static bool isNumber(String input) {
    return input.trim().contains(RegExp(r'(\d+)'));
  }


}