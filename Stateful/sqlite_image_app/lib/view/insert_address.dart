import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_image_app/model/address.dart';
import 'package:sqlite_image_app/vm/database_handle.dart';

class InsertAddress extends StatefulWidget {
  const InsertAddress({super.key});

  @override
  State<InsertAddress> createState() => _InsertAddressState();
}

class _InsertAddressState extends State<InsertAddress> {
  late DatabaseHandle db;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController relationController;

  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHandle();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    relationController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    relationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double appWidth = screenSize.width ~/ 100 * 100;

    return Scaffold(
      appBar: AppBar(title: Text('주소록 입력')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: '이름을 입력하세요'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: '전화번호 입력하세요'),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: '주소를 입력하세요'),
                ),
                TextField(
                  controller: relationController,
                  decoration: InputDecoration(labelText: '관계를 입력하세요'),
                ),

                // ElevatedButton(
                //   onPressed: () => getImageFromDevice(ImageSource.camera),
                //   child: Text('Camera'),
                // ),
                Container(
                  width: appWidth - 8,
                  height: 200,
                  color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      imageFile != null
                          ? Image.file(File(imageFile!.path))
                          : Text('이미지를 선택해 주세요'),
                      
                      Container(
                        width: appWidth/10,
                        height: appWidth/10,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        
                        child: IconButton(
                          onPressed: () =>
                              getImageFromDevice(ImageSource.gallery),
                          icon: Icon(Icons.image),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => insertAction(),
                  child: Text('저장'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==== Functions
  Future getImageFromDevice(ImageSource src) async {
    // 이미지 경로를 가져온다.
    final XFile? pickedFile = await picker.pickImage(source: src);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = pickedFile; //  XFile(pickedFile.path);
      setState(() {});
    }
  }

  Future insertAction() async {
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    Address address = Address(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      relation: relationController.text.trim(),
      image: getImage,
    );
    int check = await db.insertAddress(address);
    if (check == 0) {
      //error
      Get.snackbar("ERROR", "에러가 발생했습니다.");
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      title: '입력 결과',
      middleText: '입력이 완료됬습니다.',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
