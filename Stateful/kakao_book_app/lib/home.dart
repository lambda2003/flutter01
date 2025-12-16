import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List data;
  Map<String,dynamic> metaData = {};
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  int page = 1;
  final int pageSize = 10;
  late ScrollController scrollController;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener((){
      // 리스트의 마지막일 경우
      if(scrollController.offset >= scrollController.position.maxScrollExtent 
          && !scrollController.position.outOfRange
      ){
        getJSONData(searchController.text.trim(), 'next');
      }
    });
    data = [];
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KaKao Rest API Exercise')),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          FloatingActionButton(
            onPressed: () => getJSONData('이순신','prev'),
            child: Icon(Icons.navigate_before_sharp),
          ),
           FloatingActionButton(
            onPressed: () => getJSONData('이순신','next'),
            child: Icon(Icons.navigate_next_sharp),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            metaData.isNotEmpty ?
              Text('북 COUNT : ${pageSize*page } - 총갯수 ${metaData['total_count']}')
            : Text(''),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search 키워드를 넣어주세요',
                ),
                keyboardType: TextInputType.text,
                onSubmitted: (String value)=>searchSubmitted(value),
                // onTap: ()=>searchController.text=''
              ),
            ),
            data.isEmpty
                ? Text(
                    '데이터가 없습니다.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : isLoading
                ? const CircularProgressIndicator()
                : Container(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height-180,
                  child: ListView.builder(
                    controller: scrollController,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            spacing: 10,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: data[index]['thumbnail'].isNotEmpty &&
                                      data[index]['thumbnail'] != ''
                                  ? Image.network(
                                      data[index]['thumbnail'],
                                      width: 50,
                                    
                                    )
                                  : Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey[400],
                                    ),
                              ),
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data[index]['title'].toString().length >26
                                      ? Text(
                                          data[index]['title']
                                              .toString()
                                              .replaceRange(
                                                26,
                                                data[index]['title']
                                                    .toString()
                                                    .length,
                                                '...',
                                              ),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          data[index]['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                  Row(
                                    children: getAuthorsText(
                                      data[index]['authors'],
                                    ),
                                  ),
                                  // data[index]['authors']!=null&& data[index]['authors'].length>0
                                  // ? Text(data[index]['authors'][0])
                                  // : Text(''),
                                  data[index]['sale_price'] > 0
                                      ? Text('${data[index]['sale_price']} 원')
                                      : Text('free'),
                                  Text(data[index]['status']),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ),
          ],
        ),

        // FutureBuilder(
        //   future: getJSONDataFuture(),
        //   builder: (context, snapshot) {
        //     var data = snapshot.data != null
        //         ? json.decode(utf8.decode(snapshot.data!.bodyBytes))
        //         : [];
        //     if (data == null || data.length == 0)
        //       return Text('No Data');
        //     else {
        //       return ListView.builder(
        //         itemCount: data.length,
        //         itemBuilder: (context, index) {
        //           return Card(
        //             child: Row(
        //               spacing: 10,
        //               children: [
        //                 data[index] != null &&
        //                         data[index]['thumbnail'] != ''
        //                     ? Image.network(
        //                         data[index]['thumbnail'],
        //                         width: 100,
        //                       )
        //                     : Text('aa'),
        //                 Column(
        //                   children: [
        //                     data[index] != null
        //                         ? Text(
        //                             data[index]['title'],
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                           )
        //                         : Text('bb'),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  // == Function
  List<Widget> getAuthorsText(data) {
    int length = data.length;
    return List.generate(
      data.length,
      (i) => Text('${data[i]}${i >= length - 1 ? '' : ','}'),
    );
    // return Text('${data[i]} ${i>=data[index]['authors'].length-1?'':','}'),
  }

  searchSubmitted(String value) {
    data.clear();
    page = 1;
    if(searchController.text.trim().isNotEmpty) getJSONData(value.trim(),'next');

  }

  getJSONData(String kwd,String direction) async {
    isLoading = true;
    setState(() {});
   
    kwd = kwd.replaceAll(' ', ',');
    // kwd = Uri.encodeComponent(kwd);
    print('=====${page}');
    var url = Uri.parse(
      'https://dapi.kakao.com/v3/search/book?target=title&query=[${kwd}&page=${page}&size=$pageSize]',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 50f8b689a45dd8084241e56ebcfe92b7"},
    );

    if (response.body.isNotEmpty) {
     
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      // print(dataConvertedJSON["documents"][0]["thumbnail"]);
      data.addAll(dataConvertedJSON["documents"]);
      metaData = dataConvertedJSON["meta"];
      if(direction=='next'){
        page++;
        // setState(() {});
      }else{
        if(page>1) {
          page--;
          // setState(() {});
        }
      }
    }
    
    isLoading = false;
    setState(() {});
    
    
  }

  Future<http.Response> getJSONDataFuture() async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v3/search/book?target=title&query=코로나19',
    );
    var response = http.get(
      url,
      headers: {"Authorization": "KakaoAK 50f8b689a45dd8084241e56ebcfe92b7"},
    );
    return response;
  }
}
