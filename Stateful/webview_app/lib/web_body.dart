import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBody extends StatefulWidget {
  final String siteName;
  const WebBody({super.key, required this.siteName});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  // Property
  late WebViewController controller; // Web Controller
  late bool isLoading;
  late String siteName;

  @override
  void initState() {
    super.initState();
    isLoading = true; // CircularProgressIndicator 활성
    siteName = widget.siteName;

    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      ) //..은 controller. 줄여 쓰는 dart의 문법.
      ..setNavigationDelegate(
        NavigationDelegate(
          //로딩상태 확인
          onProgress: (progress) {
            isLoading = true;
            setState(() {});
          },
          onPageStarted: (url) {
            isLoading = true;
            setState(() {});
          },
          onPageFinished: (url) {
            isLoading = false;
            setState(() {});
          },
          onWebResourceError: (error) {
            //해당 주소가 없을 때
            isLoading = false;
            setState(() {});
          },
        ),
      )
      ..loadRequest(Uri.parse("https://$siteName"));
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: controller),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.error,
        foregroundColor: Theme.of(
          context,
        ).colorScheme.onError,
        onPressed: () => backProcess(context),
        child: Icon(Icons.arrow_back),
      ),
    );
  } // build

  //-------- Functions --------
  void backProcess(BuildContext context) async {
    // <<<<<<<
    if (await controller.canGoBack()) {
      controller.goBack();
    } else {
      snackBarFunction();
    }
  }

  void snackBarFunction() {
    Get.snackbar(
      "Warning!",
      "No more to go!",
      duration: Duration(seconds: 2),
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }
} // class
