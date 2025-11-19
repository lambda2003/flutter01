import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 초기 시작 값은 7단부터
  int num = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${num}단"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('구구단 Picker'),
            SizedBox(
              width: 300,
              height:150,
              child: CupertinoPicker(
                itemExtent: 30,
                
                scrollController: FixedExtentScrollController(initialItem:num-1),
                onSelectedItemChanged: (index) {

                  num = index+1;
                  setState(() {});
                },
                children: List.generate(
                  9,
                  (index) => SizedBox(child:Text('${(index+1)}')),
                ),
              ),
            ),
            Container(
              width: 300,
              color: Colors.green,
              child: Column(
                children:
                List.generate(
                  9, 
                  (index) => SizedBox(child: 
                    Text('${num} x ${index+1} = ${(index+1)*num}'),
                  ),
                ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
