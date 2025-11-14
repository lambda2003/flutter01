import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () =>
                snackBarFunction(context, 'Snackbar', 3, Colors.blue),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Snackbar Button"),
          ),
          ElevatedButton(
            onPressed: () =>
                snackBarFunction(context, 'Elevated', 1, Colors.red),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Elevated Button"),
          ),
        ],
      ),
    );
  }

  snackBarFunction(
    BuildContext context,
    String buttonType,
    int second,
    Color bacgroundColor,
  ) {
    // 하단에 뜨는 Menu
    // memory와 많이 연관됨
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bacgroundColor,
        duration: Duration(
          seconds: second, //buttonType=="Snackbar"? 1 : 3, // 1초
        ),

        content: Text('${buttonType} Button is clicked'),
      ), // SnackBar Widget (Style)
    );

  }
}
