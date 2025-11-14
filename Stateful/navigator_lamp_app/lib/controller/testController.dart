

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();


  void requestFocus() {
    focusNode.requestFocus();
  }

  void unfocus() {
    focusNode.unfocus();
  }


  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    print('=============TestController disponsed');
    super.onClose();
  }

  @override
  void dispose() {
    print('===============TestController disposed');
    super.dispose();
  }


} 