import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';



class CameraScreen extends StatefulWidget {
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  PickedFile image;
  final picker = ImagePicker();

  void getImage() async {
    // Allows user to pick an image from emulator's default gallery images
    image = await picker.getImage(source: ImageSource.gallery);
    

    setState(() {
      // if (pickedFile != null) {
      //   image = File(pickedFile.path);
      // } else {
      //   print('No image selected.');
      // }
    });
  }

  @override
  Widget build(BuildContext context){
    if (image == null) {
      return Center(
      child: RaisedButton(
        child: Text('Select Photo'),
        onPressed: () {
          getImage();
        },)
      );
    } else {
      // Once have image loaded, display image and new button to post image to wasteagram
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(image.path)),
            SizedBox(height:40),
            RaisedButton(
              child: Text('Post it'),
              onPressed: (){

              })
          ],
        ),
      );
    }
  }
}