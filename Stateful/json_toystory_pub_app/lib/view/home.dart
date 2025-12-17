import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:json_toystory_pub_app/view/edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  List data = [];
  List titleData = [];
  bool _initLoad = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    try {
      await Future.wait([
        // getTitleData(), 
        getJSONData()]
      );
      _initLoad = true;
      setState(() {});
    } catch (e) {
      debugPrint('ERROR: === $e');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    if (!_initLoad) {
      return Scaffold(body: Center(child: const CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('JSON TEST'), centerTitle: true),
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) =>
                        Get.to(
                          () => EditView(),
                          arguments: [data[index], index],
                        )!.then((d) {
                          // title, index
                          if(d!=null){
                            data[d['index']]['title'] = d['title'];
                            setState(() {});
                          }
                        }),

                    backgroundColor: Colors.green,
                    icon: Icons.delete,
                    label: 'Edit',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => deleteAction(index),

                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Card(
                child: Row(
                  children: [
                    Image.network(data[index]['image'], width: 50),
                    Text('${data[index]['title']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Functions

  deleteAction(int index) {
    data.removeAt(index);
    setState(() {});
  }

  Future<void> getJSONData() async {
    var url = Uri.parse('https://zeushahn.github.io/Test/movies.json');
    var response = await http.get(url);
    if (response.body.isNotEmpty) {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));

      data.addAll(dataJson['results']);
      setState(() {});
    }
  }

  Future<void> getTitleData() async {
    var url = Uri.parse('https://zeushahn.github.io/Test/pixabay.json');
    var response = await http.get(url);
    if (response.body.isNotEmpty) {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));

      titleData.addAll(dataJson['results']);
    }
  }
}
