import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  // Property

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  File? imgFile;
  
  int firstDisp = 0;
  var args = Get.arguments;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(args == null){
      Get.back();
    }
    nameController.text = args[1].name;
    codeController.text = args[1].code;
    deptController.text = args[1].dept;
    phoneController.text = args[1].phone;
    

  }


  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    deptController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "학번을 입력하세요"
              ),
              readOnly: true,
            ),
             TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "이름을 입력하세요"
              ),
            ),
             TextField(
              controller: deptController,
              decoration: InputDecoration(
                labelText: "전공을 입력하세요"
              ),
            ),
             TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "전번을 입력하세요"
              ),
            ),
            ElevatedButton(
              onPressed: ()=>getImageFromGallery(ImageSource.gallery),
              child: Text('이미지')
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Center(
                child: imageFile == null
                ? Image.network(args[1]!.image,width:70)
                : Image.file(File(imageFile!.path)),
              ),
            ),
             ElevatedButton(
              onPressed: ()=>UpdateAction(),
              child: Text('입력')
            ),
          ],

        ),
      )

    );
  }

  // ===
  void getImageFromGallery(ImageSource source) async {
      final XFile? pickedFile = await picker.pickImage(source: source);
      imageFile = XFile(pickedFile!.path);
      imgFile = File(imageFile!.path);
      firstDisp = 1;
      setState(() {});
  }

  void UpdateAction() async {
    try{

      if(firstDisp==1){
        await deleteImage();
        String image = await preparingImage();

        FirebaseFirestore.instance.collection('students').doc(args[0]).update({
          'code': codeController.text.trim(),
          'name': nameController.text.trim(),
          'dept': deptController.text.trim(),
          'phone': phoneController.text.trim(),
          'image': image

        });
      }else{
         FirebaseFirestore.instance.collection('students').doc(args[0]).update({
          'code': codeController.text.trim(),
          'name': nameController.text.trim(),
          'dept': deptController.text.trim(),
          'phone': phoneController.text.trim()

        });
      }
      _showDialog();
    }catch(error){
      print('ERROR: ============');
      print(error);
    }
  }

  Future<String> preparingImage() async {
    final firebaseFirestore = FirebaseStorage.instance
    .ref()
    // .child('')
    .child("${codeController.text.trim()}.png");
    await firebaseFirestore.putFile(imgFile!);
    String downloadURL = await firebaseFirestore.getDownloadURL();  
    return downloadURL;  
  }

  Future<void> deleteImage() async {
    final firebaseStorge = FirebaseStorage.instance
    .ref()
    // .child('')
    .child("${codeController.text.trim()}.png");
    await firebaseStorge.delete();

  }

  void _showDialog() {
    Get.defaultDialog(
      title: "메세지",
      content: Text('수정 성공했습니다.'),
      actions: [
        TextButton(onPressed: (){
          Get.back();
          Get.back();
        }, child: Text('확인'))
      ]
    );
  }


}