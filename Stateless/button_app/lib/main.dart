import 'package:button_app/home.dart';
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
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {'/home': (context) => Home(), '/p': (context) => Home()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyNavi(),
    );
  }
}

class MyNavi extends StatefulWidget {
  const MyNavi({super.key});

  @override
  State<StatefulWidget> createState() => _MyNavi();
}

class _MyNavi extends State<MyNavi> {
  int _selectedIndex = 0;
  String c = '';
  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onText(String c) {
    setState(() {
      this.c = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BUTTON EXAMPLE')),
      body: Center(
        child: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                // FatArrow
                onPressed: () => onMouseAction('textButton', 'short'),
                onLongPress: () => onMouseAction('textButton', 'long'),

                child: Text(
                  'Text Button ${_selectedIndex}',
                  // style:TextStyle(fontSize: 20,)
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.green[400],

                  // shadowColor: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  List<String> list = multiplicatioTable(5);
                  c = '';
                  for (String v in list) {
                    c = "$c $v";
                  }
                  _onText(c);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: Text('구구단 5단 출력'),
              ),
              OutlinedButton(
                onPressed: () {
                  List<String> list = multiplicatioTable(7);
                  c = '';
                  for (String v in list) {
                    c = "$c $v";
                  }
                  _onText(c);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
                child: Text("구구단 7단 출력"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.home),
                style: TextButton.styleFrom(
                  minimumSize: Size(50,40),
                  maximumSize: Size(150,40),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: Text("Go to Home"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                      child: Text("TextButton Icon")
                    ),
                    ElevatedButton(
                      onPressed: (){}, 
                    
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                      child: Text("ElevatedButton"),
                    )
                  ],
                ),
              ),
              Text(c),
            ],
          ),
          Text("Tab::Page"),
        ][_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: "Page",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapped,
        selectedItemColor: Colors.green,
      ),
    );
  }

  //------ Function
  void onMouseAction(String n, String action) {
    if (action == 'long') {
      print("Long - ${n} Button clicked!!1");
    } else {
      print("Short - ${n} Button clicked!!1");
    }
  }

  multiplicatioTable(int d) {
    List<String> list = [];
    for (int i = 1; i < 10; i++) {
      list.add("${d}x${i}=${d * i}");
      // '${d}단 ${d}x${i}=${d*i}';
    }
    return list;
  }
} // _MyNavi Class
