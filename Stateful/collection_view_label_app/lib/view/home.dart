import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<String> heroList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heroList = [];
    _addHero();
  }

  _addHero(){
    heroList.add('유비');
    heroList.add('관우');
    heroList.add('장비');

    heroList.add('조조');
    heroList.add('여포');
    heroList.add('초선');

    heroList.add('손견');
    heroList.add('장양');
    heroList.add('손책');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('삼국지 인물'),
        actions: [
          IconButton(
            onPressed: (){
              Get.toNamed('/insert')!.then((value){
                if(value != null){
                  heroList.add(value);
                  setState(() {});
                }
              });
            }, 
            icon: Icon(Icons.add_outlined)
          )
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: heroList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10, // 가로
              mainAxisSpacing: 10,  // 세로
            ), 
            itemBuilder: (context, index){
              return Dismissible(
                key: ValueKey(heroList[index]),
                direction: DismissDirection.down,
                onDismissed: (direction){
                  heroList.remove(heroList[index]);
                  setState(() {});
                },
                background: Container(
                  alignment: Alignment.topCenter,
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Icon(Icons.delete_forever),
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed('/detail',
                        arguments: {"data": heroList[index] ,"index":index}
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      child: Center(
                        child: Text(
                          '${heroList[index]}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryContainer
                          ),
                        )
                      )
                    ),
                  ),
                ),
              );
            } 
          ),
        ),
      )
    );
  }
}