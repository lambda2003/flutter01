import 'package:drawer_app/functions/general.dart';
import 'package:drawer_app/view/receive_mail_box.dart';
import 'package:drawer_app/view/send_mail_box.dart';
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
            onPressed: () => MyGeneralFunction.buttonClickDirection(context, 'send_page'),
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () => MyGeneralFunction.buttonClickDirection(context, 'receive_page'),
            icon: Icon(Icons.search),
          ),
          
        ],

        backgroundColor: Colors.blue,
        toolbarHeight: 100,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName:  Text('Pikachu'),
              accountEmail: Text('pikachu@xxx.com'),
              currentAccountPicture: Image.asset('images/pikachu-1.jpg'),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/pikachu-1.jpg'),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('images/smile.png'),
                ),
              ],
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home,color:Colors.black),
              title: Text('Home'),
              subtitle: Text('-- home'),
              onTap: () => MyGeneralFunction.removeContext(context,1),
            ),

            ListTile(
              leading: Icon(Icons.settings,color:Colors.red),
              title: Text('Settings'),
              subtitle: Text('-- settings'),
              onTap: () => MyGeneralFunction.buttonClickDirection(context, 'send_page'),
            ),
            ListTile(
              leading: Icon(Icons.settings,color:Colors.blue),
              title: Text('자주 묻는 질문'),
              subtitle: Text('Q&A'),
              onTap: () => MyGeneralFunction.buttonClickDirection(context, 'receive_page'),
            ),
            
          ],
        ),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text('alert'),
              onTap: (){
                AlertDialog(actions: [
                  Text('aa')
                ],);
              }
            ),
            ElevatedButton(
              onPressed: () => MyGeneralFunction.buttonClickDirection(context, 'send_page'),
            
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
              onPressed: () => MyGeneralFunction.buttonClickDirection(context, 'receive_page'),
              child: Text('받은  편지함'),
            ),
          ],
        ),
      ),
    );
  }
}
