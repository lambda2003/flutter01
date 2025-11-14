import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  TextEditingController _controller = TextEditingController();

  String _imagePath = 'images/lamp_on.png';
  bool _isOn = true;
  double _turnValue = 0;
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // // Get Size of Screen
    // use the size to display image and container.
    // todo: store size data into Generic Store. 
    Size screenSize = MediaQuery.of(context).size;
    double baseWidth = screenSize.width~/100*100;
    double baseHeight = baseWidth*1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Main 화면'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () => goToEdit(), icon: Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: baseHeight/4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '글자를 넣으세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(_turnValue / 360),
              child: Container(
                width: baseWidth/3,
                child: Image.asset(_imagePath),
              ),
            ),

            SizedBox(
              child: Column(
                children: [
                  Slider(
                    value: _turnValue,
                    min: -360,
                    max: 360,
                    divisions: 20,
                    label: _turnValue.toStringAsFixed(2),
                    onChanged: (value) => changeTurn(value),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Start')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  goToEdit() async {
    //
    if (!_controller.text.trim().isEmpty) {
      dynamic result = null;
      try {
        result = await Get.toNamed(
          '/edit',
          arguments: {'title': _controller.text.trim(), 'isOn': _isOn},
        );
      } catch (e) {
        Get.snackbar(
          'Error가 발생했습니다',
          '결과값을 가져올수 없습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (result != null && result['title'] != null) {
        _isOn = result['isOn'];
        if (_isOn)
          _imagePath = 'images/lamp_on.png';
        else
          _imagePath = 'images/lamp_off.png';

        _controller.text = result['title'];
        setState(() {});
      }
    } else {
      Get.snackbar(
        '텍스트필드',
        '글자를 넣어주세요.',
        backgroundColor: Colors.amber,
        colorText: Colors.white,
      );
    }
  }

  changeTurn(double value) {
    _turnValue = value;
    setState(() {});

  }
}


