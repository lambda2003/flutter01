import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:must_eat_place_app/model/place.dart';
import 'package:must_eat_place_app/vm/database_handler.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  // Property

  DatabaseHandler db = DatabaseHandler();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController estimateController = TextEditingController();

  XFile? imageFile;
  late ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    latController.dispose();
    lngController.dispose();
    nameController.dispose();
    phoneController.dispose();
    estimateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맛집추가'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () => getImagefromDevice(ImageSource.gallery),
              child: Text('Image'),
            ),
            Container(
              width: 400,
              height: 200,
              color: Colors.grey,
              child: imageFile != null
                  ? Image.file(File(imageFile!.path), width: 200)
                  : Center(child: Text('select image')),
            ),

            Row(
              spacing: 10,
              children: [
                Text('위치 : '),
                SizedBox(
                  width: 175,
                  child: TextField(
                    controller: latController,
                    decoration: InputDecoration(
                      labelText: '위도',
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                SizedBox(
                  width: 175,
                  child: TextField(
                    controller: lngController,
                    decoration: InputDecoration(
                      labelText: '경도',
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: 10,
              children: [
                Text('이름 :'),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: '이름을 입력하세요',
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Text('전화 :'),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: '전화번호를 입력하세요',
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: 10,
              children: [
                Text('평가 :'),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: estimateController,
                    decoration: InputDecoration(
                      labelText: '평가를 입력하세요',
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => insertAction(),
                child: Text('입력'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // == Functions
  getImagefromDevice(ImageSource src) async {
    final XFile? pickedFile = await picker.pickImage(source: src);
    if (pickedFile == null) {
      imageFile = null;
    } else {
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
  }

  Future<void> insertAction() async {
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    Place place = Place(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text.trim()),
      lng: double.parse(lngController.text.trim()),
      image: getImage,
      initDate: DateTime.now(),
    );
    print('======================');
    int result = await db.insertData(place);

    if (result != 0) {
      // success

      // Get.snackbar("알림", "성공적으로 저장 됬습니다.",backgroundColor: Colors.green);
      Get.back();
      print('=================$result');
    } else {
      // fail
      Get.snackbar(
        "에러",
        "저장하는데 실패했습니다. 다시 시도해 보세요.",
        backgroundColor: Colors.red,
      );
    }
  }
}
