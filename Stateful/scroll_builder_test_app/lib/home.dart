import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property
  late List<String> animalList;
  late List<Color> animalColor;
  late String selectedName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animalList = [
      'bee.png',
      'cat.png',
      'cow.png',
      'dog.png',
      'fox.png',
      'monkey.png',
      'pig.png',
      'wolf.png',
    ];
    animalColor = [
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
    ];
    selectedName = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaa'),
      ),
      body:Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('원하는 동물을 선택하세요'),
            ),
            Text(selectedName),
            SizedBox(
              height:100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: animalList.length,  
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: () => rebuildBorder(index),
                    child: Container(
                      height:100,
                      width:100,
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color:animalColor[index],
                          width: 2.0,
                        ),
                      ),
                      child: Image.asset('images/${animalList[index]}')
                    ),
                  );
                }
              ),
            )
          ],
        )
      )
    );
  }

  // Functions
  rebuildBorder(int index){
    for(int i=0; i<animalColor.length-1;i++){
      animalColor[i] = Colors.yellow;
    }

    animalColor[index] = Colors.red;
    selectedName = animalList[index].replaceAll('.png','');
    setState(() {});
  }
}