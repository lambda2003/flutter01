
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listview_todo_ex_app_get/model/TodoList.dart';


class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  // Property
  var args = Get.arguments ?? [false];
  late TodoList item;
  late int repoIndex;
  @override
  void initState() {
   
    super.initState();
    if(args[0]==true && args.length>1){
      item = args[1];
      repoIndex = args[2];
    }else{
      item = TodoList(imagePath: '', title: 'empty');
      repoIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // int id = args['id']!=null?args["id"]:0;
    // print('$id ==================================id');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        actions: [
          IconButton(onPressed: () async {
            
            // Navigator.of(context).pushNamed('/update',arguments: {
            //   "id": args["id"]
            // }).then((d)=>refreshState());
            var returnResult = await Get.toNamed('/update', arguments: [true,args[1],repoIndex]);
            refreshState(returnResult);

          }, icon: Icon(Icons.update))
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item.imagePath !=''? item.imagePath : '', width:  60),
            Text(item.imagePath !=''?item.title:'empty'),
            // ElevatedButton(onPressed:()=>Get.back() , child: Text('Return value(GET)'))
          ],
        ),
      ),
    );
  }

  // === Function
  refreshState(returnValue) {
    // After DB updating, refresh the page. 
    if (returnValue != null && returnValue[0] == true) {
      item = returnValue[1];
      setState(() {});
    }
  }
}