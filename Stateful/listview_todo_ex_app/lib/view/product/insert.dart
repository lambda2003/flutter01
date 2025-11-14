import 'package:flutter/material.dart';
import 'package:listview_todo_ex_app/model/TodoList.dart';
import 'package:listview_todo_ex_app/util/ItemRepository.dart';

class ProductInsert extends StatefulWidget {
  const ProductInsert({super.key});

  @override
  State<ProductInsert> createState() => _ProductInsertState();
}

class _ProductInsertState extends State<ProductInsert> {
  // Property
  late TextEditingController _tc1;
  // ItemRepository<TodoList> repository = ItemRepository();
  
  bool _isBuy = true;
  bool _isAppoint = false;
  bool _isStudy = false;
  String _image = 'images/cart.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tc1 = TextEditingController();
  }

  @override
  void dispose() {
    _tc1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert')),
      body: Center(
        child: Column(
          children: [
            Switch(
              value: _isBuy, 
              onChanged: (value)=>choose(value,'buy'),
            ),
            Switch(
              value: _isAppoint, 
              onChanged: (value)=>choose(value,'appoint'),
            ),
            Switch(
              value: _isStudy, 
              onChanged: (value)=>choose(value,'study'),
            ),
            TextField(controller: _tc1, keyboardType: TextInputType.text),
            ElevatedButton(onPressed: () => add(), child: Text('추가')),
          ],
        ),
      ),
    );
  }

  // == Functions
  add() {
    if (!_tc1.text.isEmpty && (_isBuy||_isAppoint||_isStudy)) {
      
      ItemRepository.items.add(
        TodoList.fromJson({'imagePath': _image, 'title': _tc1.text}),
      );
      // setState(() {
        
      // });
      Navigator.of(context).pop();
    }
  }

  choose(bool value, String n) {
    if(n == 'study'){
       
      if(!_isBuy && !_isAppoint && value){
        _image = 'images/pencil.png';
        _isStudy = true;
      }else{
        _isStudy = false;
      }
    }else if(n == 'appoint'){
      
      if(!_isBuy && value && !_isStudy){
        _image = 'images/clock.png';
        _isAppoint = true;
      }else{
         _isAppoint = false;
      }
    }else{
     
      if(value && !_isAppoint && !_isStudy){
        _image = 'images/cart.png';
         _isBuy = true;
      }else{
         _isBuy = false;
      }
    }
    setState(() {
      
    });
  }
}
