import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:json_pixabay_app/item_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String kwd = 'big data';
  List data = [];
  int page = 1;
  int per_page = 10;
  bool isLoading = false;
  List<String> kwds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchTextController.text = kwd;
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print('aaaaa');
        getJSONData();
      }
    });

    getJSONData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(labelText: '찾는 이미지를 검색해 보세요'),
                    onSubmitted: (value) => searchKwd(),
                    onTap: (){searchTextController.text = '';},
                  ),
                  Row(
                    children: [
                      kwds.length>0?Text('키워드: '): Text(''),
                      Row(
                        spacing: 10,
                        children: List.generate(kwds.length, (index)=>
                          GestureDetector(
                            onTap:(){
                            
                                searchTextController.text=kwds[index];
                                getJSONData();
                              
                              
                            },
                            child: Text(kwds[index]))
                      )
                      ),
                    ],
                  )
                ],
              ),
            ),
            isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : 
            Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height -250,
              // color: Colors.green,
              child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(5),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.72,
                          ),

                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ItemView(url: data[index]['webformatURL'],w: data[index]['webformatWidth'], h:data[index]['webformatHeight']),
                            );
                            // print();
                          },
                          child: Container(
                            width: double.parse(
                              data[index]['previewWidth'].toString(),
                            ),
                            height: double.parse(
                              data[index]['previewHeight'].toString(),
                            ),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(data[index]['previewURL']),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.green,
                            ),

                            // selected: index < 4,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  // == Functions

  searchKwd() {
    kwd = searchTextController.text.trim();
    page = 1;
    data.clear();
    getJSONData();
  }

  getJSONData() async {
    isLoading = true;
    setState(() {});
    kwd = kwd.replaceAll(' ', '+');
      if(!kwds.contains(kwd)){
        kwds.add(kwd);
        if(kwds.length>5){
          kwds.removeAt(0);
        }
      }
    var url = Uri.parse(
      'https://pixabay.com/api/?key=53746123-732a2b7238180e66c1522df6b&q=$kwd&image_type=photo&page=$page&per_page=$per_page',
    );

    var response = await http.get(url);

    if (response.body.isNotEmpty) {
      var dataJsonParse = json.decode(utf8.decode(response.bodyBytes));
      data.addAll(dataJsonParse['hits']);
      print(dataJsonParse['hits']);
    }
    isLoading = false;
    setState(() {});
  }
}
