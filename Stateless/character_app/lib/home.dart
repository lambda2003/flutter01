import 'package:character_app/layout/footer.dart';
import 'package:character_app/layout/header.dart';
import 'package:character_app/layout/top.dart';
import 'package:character_app/layout/topDrawer.dart';
import 'package:character_app/page.dart';
import 'package:character_app/page1.dart';
import 'package:flutter/material.dart';

// final header = Padding(
//       padding: const EdgeInsets.fromLTRB(0, 10, 0,0),
//       child: Column(
//         spacing: 10,
//         children: [
//           CircleAvatar(
//             backgroundImage: AssetImage('images/Lee.jpg'),
//             radius: 50,
//           ),
//           Divider(height: 5),
//         ],
//       ),
//     );

// final footer =  Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         spacing: 10,
//         children: [
//           Divider(height: 5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 10,
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('images/turtle.gif'),
//                 radius: 20,
//                 backgroundColor: Colors.orange[300],
//               ),
//               Text('Footer'),
//             ],
//           ),
//         ],
//       ),
//     );

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
 
    
    // var x = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: TopApp(),
      drawer: TopDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Page1(),
            Footer(),
            // Card(
            //   child: Column(
            //     children: [
            //       ListTile(
            //         title: Text('listTitle1'),
            //         subtitle: Text('subListTitle1'),
            //         leading: Icon(Icons.check_box_outline_blank),
            //       ),
            //       ListTile(
            //         title: Text('listTitle2'),
            //         subtitle: Text('subListTitle2'),
            //         leading: Icon(Icons.check_box_outlined),
            //       ),
            //       ListTile(
            //         title: Text('listTitle2'),
            //         subtitle: Text('subListTitle2'),
            //         leading: Icon(Icons.check_box_outline_blank),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CircleAvatar(
            //     backgroundImage: AssetImage('images/turtle.gif'),
            //     radius: 40,
            //     backgroundColor: Colors.orange[300],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        children: [Text('11'),Text('22')],
      ),
    );
  }
}
