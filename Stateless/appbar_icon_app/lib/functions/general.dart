import 'package:flutter/material.dart';

class MyGeneralFunction {
  static void sendSnackMessage(BuildContext context, String type, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == 'warn'
            ? Colors.orange
            : type == 'error'
            ? Colors.red
            : Colors.grey[300],
        content: Text(
          "$type : $message",
          style: TextStyle(color: type == 'info' ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
