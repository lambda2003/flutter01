import 'package:flutter/material.dart';
import 'package:webview_app/web_body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  //property
  late TabController controller;
  late List siteName;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    siteName = [
      'www.naver.com',
      'www.google.com',
      'www.daum.net',
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('webview_tabbar')),
      body: TabBarView(
        controller: controller,
        children: [
          WebBody(siteName: siteName[0]),
          WebBody(siteName: siteName[1]),
          WebBody(siteName: siteName[2]),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer,
        height: 100,
        child: TabBar(
          labelColor: Colors.blueAccent,
          controller: controller,
          tabs: [
            Tab(
              icon: Image.asset(
                'images/naver.png',
                width: 30,
                height: 30,
              ),
              text: '네이버',
            ),
            Tab(
              icon: Image.asset(
                'images/google.png',
                width: 30,
                height: 30,
              ),
              text: '구글',
            ),
            Tab(
              icon: Image.asset(
                'images/naver.png',
                width: 30,
                height: 30,
              ),
              text: '네이버',
            ),
          ],
        ),
      ),
    );
  }
}
