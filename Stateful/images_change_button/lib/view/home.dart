import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  late final List<String> _images;
  late int _currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _images = [
      'flower_01.png', // 0
      'flower_02.png', // 1
      'flower_03.png', // 2
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(_images[_currentPage]),
          Container(
            width: 300,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('images/${_images[_currentPage]}'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${_images[_currentPage]}',style:TextStyle(color:Colors.white)),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(30.0),
          //     child: Image.asset('images/${_images[_currentPage]}'),
          //   ),
          // ),

          // Card(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(30.0),
          //     child: Image.asset('images/${_images[_currentPage]}'),

          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(30.0),
          //     side: BorderSide(color: Colors.grey),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => changeImage(false),
                child: Text('<< 이전'),
              ),
              ElevatedButton(
                onPressed: () => changeImage(true),
                child: Text('이후 >>'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //==== Funcation.
  changeImage(bool isNext) {
    if (isNext) {
      if (_currentPage >= _images.length - 1) {
        _currentPage = 0;
      } else {
        _currentPage++;
      }
    } else {
      if (_currentPage <= 0) {
        _currentPage = _images.length - 1;
      } else {
        _currentPage--;
      }
    }
    setState(() {});
  }
}
