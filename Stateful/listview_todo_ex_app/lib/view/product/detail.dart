
import 'package:flutter/material.dart';
import 'package:listview_todo_ex_app/util/ItemRepository.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  // Property


  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id']!=null?args["id"]:0;
    print('$id ==================================id');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed('/update',arguments: {
              "id": id
            }).then((d)=>refreshState());
          }, icon: Icon(Icons.update))
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ItemRepository.items[id].imagePath, width:  60),
            Text(ItemRepository.items[id].title),
          ],
        ),
      ),
    );
  }

  // === Function
  refreshState() {
    setState(() {
      
    });
  }
}