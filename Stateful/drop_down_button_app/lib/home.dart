import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late List<String> _items;
  late String dropDownValue;
  late String imageName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _items = ['Apple', 'Banana', 'Grape', 'Orange', 'Pineapple', 'Watermelon'];
    dropDownValue = _items[0];
    imageName = _items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('aaa'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              dropdownColor: Theme.of(context).colorScheme.primary,
              iconEnabledColor: Theme.of(context).colorScheme.error,
              value: dropDownValue,
              icon: Icon(Icons.arrow_drop_down),
              items: _items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                dropDownValue = value!;
                imageName = value;
                setState(() {});
              },
            ),
            Image.asset(
              'images/${imageName}.png',
              width: 200,
            ),
          

          ],
        ),
      ),
    );
  }
}
