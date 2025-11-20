import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  XFile? imageFile;
  late ImagePicker picker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image picker App')
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: ()=> getImageFromDevice(ImageSource.gallery), 
                  child: Text('Gallery')
                ),
                ElevatedButton(
                  onPressed: ()=>  getImageFromDevice(ImageSource.camera), 
                  child: Text('Camera')
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Center(
                child: imageFile == null 
                ? Text('Image is not selected')
                : Image.file(File(imageFile!.path))
              ),
            ),
          ],
        )
      )
    );
  }

  // ==== Functions
   getImageFromDevice(ImageSource src) async {
    final XFile? pickedFile = await picker.pickImage(source: src);
    if(pickedFile == null){
      imageFile = null;
    }else{
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
   }

}