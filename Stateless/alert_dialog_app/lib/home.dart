import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alert dialog'), centerTitle: true),
      body: Center(
        child: GestureDetector(
          onTap: () => _showDialog(context),
          child: Text('Alert Hello World'),
        ),
      ),
    );
  }

  // =========== Functions
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey,
      barrierLabel: 'aaa',
      builder: (context) {
        return AlertDialog(
        
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            textDirection: TextDirection.ltr,
            
            children: [
              Icon(Icons.info),
              Text('Page이동', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600 ))
            ],
            
          ),
            
          content: const SizedBox(
            width: 100,
            height: 100,
          
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Hello World를 터치했습니다.')],
              ),
            ),
          ),

          backgroundColor: Colors.deepPurple[100],

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/page1');
              },

              child: Text('Go to the Page 1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
