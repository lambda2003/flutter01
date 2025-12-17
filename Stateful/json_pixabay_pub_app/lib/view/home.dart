import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_pixabay_pub_app/service/color_convert.dart';
import 'package:http/http.dart' as http;
import 'package:json_pixabay_pub_app/view/second.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  List data = [];
  String query = '빅데이터';
  TextEditingController queryController = TextEditingController();

  // For publisher
  var version = 0; // 0: 한글, 1:영문
  List title = [];

  // 초기 로딩 여부
  bool _isInitLoading = true;

  // Color Convert
  ColorConvert colorConvert = ColorConvert();

  
  @override
  void initState() {
    super.initState();
    _initData();  // 비동기 초기화 함수
  }

  // 두개의 API를 모두 받은 뒤에만 화면을 그리게 하는 초기화 함수
  Future<void> _initData() async {
    try{
      await Future.wait([
        getJSONData(),
        getTitleData(),
      ]);
    }catch(e){
      debugPrint('init error: $e');
    }finally{
      // mounted 내부 변수
      if(mounted){
        _isInitLoading = false;
        setState(() {});
      }
    }
  }

  // mounted는 개발자가 선언한 변수가 아니고 
  // staefulWidget의 State 클래스가 기본으로 제공하는 property
  // - 화면이 살아있을경우  true
  // - dispose()가 호출되어 화면이 사라지면 false


  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // 사용자 OS 언어 확인
    final deviceLocale = Get.deviceLocale;
    final lang = deviceLocale?.languageCode; // 'ko','en','jp'....
    version = lang == 'ko' ? 0 : 1;

    // 초기 로딩중 다른 화면 보여줌
    if(_isInitLoading){
      // 작업중이면 
      return Scaffold(
        body: Center(child: const CircularProgressIndicator(),)
      );
    }

    return Scaffold(
      backgroundColor: colorConvert.parseColor(title[version]['color']),
      appBar: AppBar(
        title: Column(
          children: [
            Text(title[version]['title']),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width:300,
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(
                      hintText: title[version]['hint']
                    ),
                    
                  ) 
                ),
                IconButton(
                  onPressed: () async {
                    query = queryController.text.trim();
                    if(query.isEmpty){
                      // Error SnackBar
                      errorSnackBar();
                    }else{
                      await getJSONData();
                      setState(() {});
                    }
                  }, 
                  icon: Icon(Icons.search, color:Colors.blue)
                )
              ],
            ),
          ],
        ),
       
      ),
      body:Center(
        child: data.isEmpty 
        ? Text('No Data')
        : GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 200,
              height: 100,
              child: GestureDetector(
                onTap: ()=>Get.to(()=>Second(),arguments: [data[index], query]),
                child: Card(
                  color: colorConvert.parseColor(title[version]['color']),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      data[index],
                      fit: BoxFit.fill,
                    ) 
                  )
                ),
              )
            );
          },
        ),
      )
    );
  }

  // Functions
  Future<void> getJSONData() async{
     var url = Uri.parse(
      'https://pixabay.com/api/?key=53746123-732a2b7238180e66c1522df6b&q=$query&image_type=photo',
    );

    var response = await http.get(url);
    if(response.body.isNotEmpty){
      var dataConvertedData = json.decode(utf8.decode(response.bodyBytes));
      List results = dataConvertedData['hits'];
      data.clear();
      for(int i=0;i<results.length;i++){
        data.add(results[i]['webformatURL']);
      }
    }
  }

  Future<void> getTitleData() async{
    var url = Uri.parse(
      'https://zeushahn.github.io/Test/pixabay.json',
    );

    var response = await http.get(url);
    if(response.body.isNotEmpty){
      var dataConvertedData = json.decode(utf8.decode(response.bodyBytes));
      List results = dataConvertedData['results'];
      title.clear();
      title.addAll(results);
    }
  }

  errorSnackBar() {
    Get.snackbar('경고', '검색어를 입력하세요');
  }

}