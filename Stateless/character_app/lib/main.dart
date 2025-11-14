import 'package:character_app/account.dart';
import 'package:character_app/home.dart';
import 'package:character_app/page2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo1',
      initialRoute: '/',
      routes: {
        '/page2': (context) => Page2(),
        // '/account' : (context) => MyAccount(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyNavi(),
    );
  }
}

class MyNavi extends StatefulWidget {
  const MyNavi({super.key});

  @override
  State<MyNavi> createState() => _MyNavi();
}

class _MyNavi extends State<MyNavi> {
  // const _MyNavi({super.key});
  int _selectedIndex = 0;
  // static const

  // _widgetList(context){
  //    final List<Widget> _widgetOptions = <Widget>[];
  //     _widgetOptions.addAll([
  //     Column(
  //       children: [
  //         Text('MENU::tab 1'),
  //         ElevatedButton(
  //           onPressed: () => {
  //             // Navigator.of(context).pushNamed('/page2')
  //           },
  //           child: Text('button1'),
  //         ),
  //       ],
  //     ),

  //     Text('Menu::tab 2'),
  //   ]);
  //   return _widgetOptions;
  // }
  // final List<Widget> _widgetOptions = <Widget>[
  //   Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text('MENU::tab 1'),
  //       ElevatedButton(
  //         onPressed: () => {
  //           // Navigator.of(context).pushNamed('/page2')
  //         },
  //         child: Text('button1'),
  //       ),
  //     ],
  //   ),

  //   Text('Menu::tab 2'),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // body: Center(child: _widgetOptions[_selectedIndex],
      // body: Center(
      //   child: Column(
      //     children: [
      //       ElevatedButton(
      //         onPressed: () => {Navigator.of(context).pushNamed('/page2')},
      //         child: Text('button1'),
      //       ),

      //       Text('Menu::tab 2'),
      //     ],
      //   ),

      // <Widget>[
      //   Column(
      //     children: [
      //       Text('MENU::tab 1'),
      //       ElevatedButton(
      //         onPressed: () => {
      //           // Navigator.of(context).pushNamed('/page2')
      //         },
      //         child: Text('button1'),
      //       ),
      //     ],
      //   ),

      //   Text('Menu::tab 2'),
      // ]
      body: Center(
        child: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MENU::tab 1'),
              ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed('/page2')},
                child: Text('button1'),
              ),
            ],
          ),

          Text('Menu::tab 2'),
        ][_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home1"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
