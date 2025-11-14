import 'package:flutter/material.dart';

// Static functions for general purpose
class MyGeneralFunction {
  static void _sendSnackMessage(BuildContext context, String type, String message) {
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
  static void removeContext(BuildContext context,int limit) {
    int safeIndex = 0;
    while(true) {
      if(safeIndex == limit|| limit==0) break;
      if(safeIndex>10) break;
      if(Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }else {
        break;
      }
      safeIndex++;
    }
  }

  static void buttonClickDirection(context, String url) {
    removeContext(context, 1);
    Navigator.pushNamed(context, '/$url');
    
    _sendSnackMessage(context, 'info', 'Page moved to the $url');
  }

}
