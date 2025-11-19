import 'dart:async';

import 'package:collection_view_image_app/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<Map<String, String>> _items;
  double _degreeValue = 10;
  late Timer _t;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _items = [];
    _addItems();

  }

  _addItems() {
    _items.add({"name": "유비꽃", "imagePath": "flower_01.png"});
    _items.add({"name": "광우꽃", "imagePath": "flower_02.png"});
    _items.add({"name": "장비꽃", "imagePath": "flower_03.png"});
    _items.add({"name": "조조꽃", "imagePath": "flower_04.png"});
    _items.add({"name": "손권꽃", "imagePath": "flower_05.png"});
    _items.add({"name": "여포꽃", "imagePath": "flower_06.png"});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flower Graden'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 650,
              child: GridView.builder(
                itemCount: _items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return RotationTransition(
                    turns: AlwaysStoppedAnimation(_degreeValue / 360),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => Detail(), arguments: _items[index]);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "images/${_items[index]["imagePath"]}",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Transform.flip(
                                flipX: true,
                                child: Transform.rotate(
                                  angle: 0.785, // 45도
                                  child: Text(
                                    '워터마크',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            Text('${_items[index]["name"]}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Slider(
              min: -360,
              max: 360,
              divisions: 36,
              value: _degreeValue,
              label: _degreeValue.toString(),
              onChanged: (v) {
                _degreeValue = v;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*
Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 100,
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  "images/${_items[index]["imagePath"]}",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Transform.rotate(
                            angle: 0.785, // 45도
                            child: Text(
                              '워터마크',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   child: Image.asset(
                          //     "images/${_items[index]["imagePath"]}",
                          //     width: 100,
                          //   ),
                          // ),
                          // RotationTransition(
                          //   alignment: Alignment.center,
                          //   turns:AlwaysStoppedAnimation(45 / 360),
                          //   child: Text('워터마크', style: TextStyle(
                          //     color: Colors.white
                          //   ),))
                          // Transform.rotate(
                          //   angle: 0.785, // 45도
                          //   child: Text(
                          //     '워터마크',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      ),
*/