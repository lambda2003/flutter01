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
       Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width~/100 * 100;
    double screenHeight =  screenSize.height~/100 * 100;
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
           
            Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),

                margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: Stack(
                  alignment: Alignment.topRight,

                  children: [
                    imageFile != null
               ? Center(child:Image.file(File(imageFile!.path), width: 200))
                  : Center(child:Image.memory(place!.image!,width:200)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(5)
                        //   )
                        // ),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                        ),
                        onPressed: () =>
                            getImagefromDevice(ImageSource.gallery),
                        icon: Icon(Icons.image_search),
                      ),
                    ),
                  ],
                ),
              ),




              Row(
                spacing: 10,
                children: [
                  // Text(
                  //   '위치 : ',
                  //   style: TextStyle(
                  //     // fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(
                    width: screenWidth/1.85,
                    height: 40,
                    
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 3, 0, 3),
                      child: TextField(
                        controller: latController,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: '위도',
                          labelStyle: TextStyle(fontSize: 12),
                          iconColor: Colors.grey[600], 
                          icon: Icon(Icons.gps_fixed,size:25),
                           border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ), 
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: screenWidth/2-27,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        controller: lngController,
                          style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: '경도',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ), 
                        ),
                      ),
                    ),
                  ),
                ],
              ),

         
                  SizedBox(
                    width: screenWidth-5,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: nameController,
                          style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: '상점명을 입력하세요',
                          labelStyle: TextStyle(fontSize: 12),
                          icon: Icon(Icons.storefront,size:25),
                           border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            
                          ),
                           iconColor: Colors.grey[600],
                        ),
                        
                      ),
                    ),
                  ),
        
      
                  SizedBox(
                    width: screenWidth-5,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        controller: phoneController,
                          style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: '전화번호를 입력하세요',
                          labelStyle: TextStyle(fontSize: 12),
                     
                          icon:Icon(Icons.phone_android,size:25),
                           border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ), 
                        ),
                      ),
                    ),
                  ),
             
     
                  SizedBox(
                    width: screenWidth-5,

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        controller: estimateController,
                        maxLines: 6,
                        minLines: 3,
                        textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                          fontSize: 13,
                        ),
                        
                        decoration: InputDecoration(
                          labelText: '평가를 입력하세요',
                          labelStyle: TextStyle(fontSize: 12),
                           iconColor: Colors.grey[600],
                          icon:Icon(Icons.rate_review_outlined,size:25),
                          
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              
                            ), 
                        ),
                      ),
                    ),
                  ),
   

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                    ),
                
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