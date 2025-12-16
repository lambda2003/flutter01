import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List data;
  late TextEditingController searchTextController;
  late ScrollController scrollController;
  String stationName = '강남';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    searchTextController = TextEditingController();
    searchTextController.text = stationName;
    // scrollController = ScrollController();
    getJSONdata();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaaabbb'),
      ),
      body: data==null || data.length==0 
      ? Text('no data')
      :
      
      Center(
        child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      labelText: '역이름을 검색하세요'
                    ),
                    onSubmitted: (value)=>getSearch(),
                  ),
                ),
               Text('${data[0]['subwayList']}'),
                Container(
                  height: MediaQuery.of(context).size.height-200,
                  color: Colors.green,
                  child: ListView.builder(
                    
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          spacing: 10,
                          
                          children: [
                            Text('${data[index]['subwayId']}'),
                            Text('${data[index]['btrainSttus']}'),
                          
                            
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('열차 구분: ${data[index]['updnLine']}'),
                                Text('열차 방면: ${data[index]['trainLineNm']}'),
                                Text('현재 위치: ${data[index]['arvlMsg3']}'),
                                Text('도착 시간: ${data[index]['arvlMsg2']}'),
                              ],
                            ),
                            
                          ],
                        ),
                      );                
                    },
                  ),
                ),
              ],
            )
        
      )
    );
  }

  // == Functions
  void getSearch() {
    stationName = searchTextController.text.trim();
    stationName = stationName.replaceAll('역', '');
    data.clear();
    getJSONdata();
  }


  void getJSONdata() async {
    
    var url = Uri.parse(
        'http://swopenapi.seoul.go.kr/api/subway/6f767765636c616d31394d464b796e/json/realtimeStationArrival/1/5/$stationName'
    );

    var response = await http.get(url);
    print('${response.body}======');
    if(response.body.isNotEmpty){
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      
      data.addAll(dataConvertedJSON['realtimeArrivalList']);
      setState(() {});
    }


  }

}