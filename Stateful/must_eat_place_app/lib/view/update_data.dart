import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:must_eat_place_app/model/place.dart';
import 'package:must_eat_place_app/vm/database_handler.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  // Property

  Place? place = Get.arguments;

  DatabaseHandler db = DatabaseHandler();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController estimateController = TextEditingController();

  XFile? imageFile;
  late ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text  = place!.name;
    phoneController.text = place!.phone;
    estimateController.text = place!.estimate!;
    latController.text = place!.lat.toString();
    lngController.text = place!.lng.toString();

  }

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
        title: Text('맛집변경'),
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
            Container(
              width: 400,
              height: 200,
              color: Colors.grey,
              
              child: 
              Stack(
                children: [
                  imageFile != null
                  ? Center(child:Image.file(File(imageFile!.path), width: 200))
                  : Center(child:Image.memory(place!.image!,width:200)),
                   ElevatedButton(
              onPressed: () => getImagefromDevice(ImageSource.gallery),
              child: Text('Image'),
            ),
                ],
              )

              // GestureDetector(
              //   onTap: ()=>getImagefromDevice(ImageSource.gallery),
              //   child: imageFile != null
              //     ? Image.file(File(imageFile!.path), width: 200)
              //     : Image.memory(place!.image!,width:100),
              // )
              
              
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
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => updateAction(),
                  child: Text('입력'),
                ),
              ),
            ),
             
          ],
        )
      )
    );
  }

  // == Functions
  getImagefromDevice(ImageSource src) async {
    final XFile? pickedFile = await picker.pickImage(source: src);
    if(pickedFile == null){
      imageFile = null;
    }else{
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
  }

  Future<void> updateAction() async {
  
    // Place place = Place(
    //     name: nameController.text.trim(),
    //     phone: phoneController.text.trim(),
    //     estimate: estimateController.text.trim(),
    //     lat: double.parse(latController.text.trim()),
    //     lng: double.parse(lngController.text.trim()),
    //     image: null,
    //     initDate: DateTime.now()
    //   );
    
    place!.name = nameController.text.trim();
    place!.phone = phoneController.text.trim();
    place!.estimate = estimateController.text.trim();
    place!.lat = double.parse(latController.text.trim());
    place!.lng = double.parse(lngController.text.trim());

    place!.initDate = DateTime.now();

    if(imageFile != null) {
      File imageFile1 = File(imageFile!.path);
      Uint8List getImage = await imageFile1.readAsBytes();
      // place!.image = getImage;
      place!.image = getImage;
    }
  
    print('======================');
    int result = await db.updateData(place!);
  
    if(result != 0){
      // success
      
      // Get.snackbar("알림", "성공적으로 저장 됬습니다.",backgroundColor: Colors.green);
      Get.back();
        print('=================$result');
    }else{
      // fail
       Get.snackbar("에러", "저장하는데 실패했습니다. 다시 시도해 보세요.",backgroundColor: Colors.red);
      
    }

  }

}