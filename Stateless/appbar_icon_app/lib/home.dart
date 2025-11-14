import 'package:appbar_icon_app/functions/general.dart';
import 'package:appbar_icon_app/view/receive_mail_box.dart';
import 'package:appbar_icon_app/view/send_mail_box.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [Text("Navigator_AppBar")]),
        centerTitle: false,

        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/send_page');
              //  my_message(context, 'info', 'send mailbox');
               MyGeneralFunction.sendSnackMessage(context, 'info', 'send mailbox');
            },
            icon: Icon(Icons.email),
          ),
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/receive_page');
                MyGeneralFunction.sendSnackMessage(context, 'info', 'send mailbox');
              },
              child: Icon(Icons.markunread_mailbox_outlined), //Image.asset('images/smile.png', width: 30),
            ),
          ),
        ],

        backgroundColor: Colors.blue,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/send_page');
                MyGeneralFunction.sendSnackMessage(context, 'info', 'send mailbox');
              },
              child: Text('보낸  편지함'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/receive_page');
                MyGeneralFunction.sendSnackMessage(context, 'info', 'send mailbox');
              },
              child: Text('받은  편지함'),
            ),
          ],
        ),
      ),
    );
  }
}
