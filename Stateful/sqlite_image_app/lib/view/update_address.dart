import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_image_app/model/address.dart';
import 'package:sqlite_image_app/vm/database_handle.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  final Address? o_address = Get.arguments != null ? Get.arguments[0] : null;

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
    if (o_address != null) {
      db = DatabaseHandle();
      nameController = TextEditingController();
      phoneController = TextEditingController();
      addressController = TextEditingController();
      relationController = TextEditingController();

      nameController.text = o_address!.name;
      phoneController.text = o_address!.phone;
      addressController.text = o_address!.address;
      relationController.text = o_address!.relation;
      // imageFile = XFile.fromData(address!.image);
    } else {
      // NoData
      Get.snackbar("알림", "변경할 데이터가 없습니다.");
      Get.back();
    }
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





    return Scaffold(
      appBar: AppBar(title: Text('주소록 변경')),
      body: Center(
        child: Column(
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
            ElevatedButton(
              onPressed: () => getImageFromDevice(ImageSource.gallery),
              child: Text('Gallery'),
            ),
            ElevatedButton(
              onPressed: () => getImageFromDevice(ImageSource.camera),
              child: Text('Camera'),
            ),
            SizedBox(
              width: 200,
              height: 200,

              child: imageFile != null
                  ? Image.file(File(imageFile!.path))
                  : Image.memory(o_address!.image, width: 100),
            ),
            ElevatedButton(
              onPressed: () => updateAction(),
              child: Text('업데이트'),
            ),
          ],
        ),
      ),
    );
  }

  // ==== Functions
  Future getImageFromDevice(ImageSource src) async {
    final XFile? pickedFile = await picker.pickImage(source: src);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = pickedFile;
      setState(() {}); // XFile(pickedFile.path);
    }
  }

  Future updateAction() async {
      o_address!.name = nameController.text.trim();
      o_address!.phone = phoneController.text.trim();
      o_address!.address = addressController.text.trim();
      o_address!.relation = relationController.text.trim();
    if(imageFile != null){
      File imageFile1 = File(imageFile!.path);
      Uint8List getImage = await imageFile1.readAsBytes();
      o_address!.image = getImage;
    }
        // Address address = Address(
      //   id: o_address!.id,
      //   name: nameController.text.trim(),
      //   phone: phoneController.text.trim(),
      //   address: addressController.text.trim(),
      //   relation: relationController.text.trim(),
      //   image: getImage,
      // );
  

    int check = await db.updateAddress(o_address!);
    if (check == 0) {
      //error
      Get.snackbar("ERROR", "에러가 발생했습니다.");
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      title: '변경 결과',
      middleText: '변경이 완료됬습니다.',
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
