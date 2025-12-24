import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_image_app/component/global_widget.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  // Property
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  var args = Get.arguments;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  String fileName = ""; // ImagePicker에서 선택된 파일 이름

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = args['name'];
    phoneController.text = args['phone'];
    addressController.text = args['address'];
    relationController.text = args['relation'];
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
      appBar: AppBar(
        title: Text("Upload")
      ),
      body: Center(
        child: Column(
          children: [
            _buildTextFiled(nameController,'이름'),
            _buildTextFiled(phoneController,'전화번호'),
            _buildTextFiled(addressController,'주소'),
            _buildTextFiled(relationController,'관계'),

            ElevatedButton(
              onPressed: ()=>getImageFromGallery(ImageSource.gallery), 
              child: Text("이미지 가져오기")
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                ? Image.network('http://172.16.250.187:8000/view/${args['seq']}?t=${DateTime.now().microsecondsSinceEpoch}',width:100)      
                : Image.file(File(imageFile!.path),fit: BoxFit.fill)
              ),
            ),
              ElevatedButton(
              onPressed: ()=>updateItem(), 
              child: Text("업데이트")
            ),
          ],
        )
      )
    );
  }

  // == Functions
  Future<void> getImageFromGallery(ImageSource imageSource) async {
    // 이미지 정보: 위치, mimetype등등
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile == null){
     GlobalWidget.errorSnackBar("이미지를 선택해 주세요");
    }else{
      // 이미지의 위치를 얻어 온다. 
      imageFile = XFile(pickedFile.path);
      setState(() {});
    }
  }

 

  Future<void> updateItem() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://172.16.250.187:8000/update')
    );
    request.fields['seq'] = args['seq'].toString();
    request.fields['name'] = nameController.text.trim();
    request.fields['phone'] = phoneController.text.trim();
    request.fields['address'] = addressController.text.trim();
    request.fields['relation'] = relationController.text.trim();
    if(imageFile != null){
      // 이미지 위치를 통해 파일을 가져와서 multipart의 file로 전송 준비
      request.files.add(await http.MultipartFile.fromPath('file', imageFile!.path));
    }
    final response = await request.send();
    if(response.statusCode == 200){
      _showDialog();
    }else{
      GlobalWidget.errorSnackBar("업데이트중 문제가 발생 하였습니다.");
    }

  }

  void _showDialog(){
    Get.defaultDialog(
      title: "업데이트 결과",
      middleText: "업데이트가 완료 됬습니다.",
      actions: [
        TextButton(
          onPressed: (){
            Get.back();
            Get.back(result: true);
          },
          child: Text('확인'))
      ]
    );
  }

  // -- Widgets
  Widget _buildTextFiled(TextEditingController controller,String labelText){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}