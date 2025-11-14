import 'package:flutter/material.dart';

class TopDrawer extends StatelessWidget {
  const TopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 50,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(15.0),
                duration: Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
                child: Text('Drawer Header'),
              ),
            ),
            ListTile(
              title: Text('HOME'),
              // style: ListTileStyle.list,
              onTap: () {
                print('Item 1 tapped!');
                // You can add navigation, state changes, or other actions here
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Tapped Item 1')));
                
                if(Scaffold.of(context).isDrawerOpen){
                  Navigator.pop(context);
                }
                Navigator.pushNamed(context, '/home', arguments: 'home');
              },
            ),
            ListTile(
              title: Text('Page2'),
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Tapped Item 2')));
                if(Scaffold.of(context).isDrawerOpen){
                  Navigator.pop(context);
                }
                Navigator.pushNamed(context, '/account',  arguments: 'account').then((val){
                  
                });
      
              },
            ),
          ],
        ), // Populate the Drawer in the last step.
      );
  }
}
