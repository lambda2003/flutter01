import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listview_todo_ex_app_get/model/TodoList.dart';
import 'package:listview_todo_ex_app_get/util/ItemRepository.dart';

// TODO: not tested

class ProductUpdate extends StatefulWidget {
  const ProductUpdate({super.key});

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  // Property
  late TextEditingController _tc1;
  late ItemRepository<TodoList> repository;
  var args = Get.arguments ?? [false];
  late TodoList item;
  late int repoIndex;
  late bool _isBuy;
  late bool _isAppoint;
  late bool _isStudy;
  late String _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!args[0]){
      Get.back();
    }else{
      _tc1 = TextEditingController();
      _isBuy = false;
      _isAppoint = false;
      _isStudy = false;
      _image = '';
      item = args[1]; 
      repoIndex = args[2];
      
      // DB셋팅
      repository = ItemRepository<TodoList>();
    }
  }

  @override
  void dispose() {
    _tc1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    // int index = args["id"]!=null? args["id"]:0;
    setValue(repoIndex);
    return Scaffold(
      appBar: AppBar(title: Text('update')),
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
            ElevatedButton(onPressed: () => update(repoIndex), child: Text('편집')),
          ],
        ),
      ),
    );
  }
  setValue(int index) async {
    _tc1.text = item.title;
    _image = item.imagePath;
   
    setState(() {});
  }
  // == Functions
  update(int index) {
    if (!_tc1.text.isEmpty) {
      
      //DB 저장
      repository.updateItemByIndex(index,  TodoList.fromJson({'imagePath': _image, 'title': _tc1.text}));
      
      args[1] = TodoList.fromJson({'imagePath': _image, 'title': _tc1.text});
      Get.back(
        result: [true,TodoList.fromJson({'imagePath': _image, 'title': _tc1.text}),index]
      );

      // print(ItemRepository.items[index].title);
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
