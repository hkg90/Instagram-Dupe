import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/get_location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';



class PostEntryFields {
  String amount;
  String dateTime;
  var longitude;
  var latitude;
  var url;

  String toString(){
    return 'Amount: $amount, Date: $dateTime, Longitude: $longitude, Latitude: $latitude, URL: $url';
  }  
}

class CameraScreen extends StatefulWidget {
  
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  LocationData locationData;
  
  
  PickedFile image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final postFields = PostEntryFields();
  void getImage() async {
    // Allows user to pick an image from emulator's default gallery images
    image = await picker.getImage(source: ImageSource.gallery);
    locationData = await retrieveLocation();
    // Send image to Cloud Firestore - 'file_name' uses the date time stamp to create a 
    // unique file name to store the file in the Cloud
    final fileName = DateTime.now();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName.toString()+'.jpg');
    
    // Execute upload task to send image to Cloud
    UploadTask newTask = storageReference.putFile(File(image.path));
    var imageURL = await (await newTask).ref.getDownloadURL();
    print(imageURL);
    

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
      return Material(
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(File(image.path)),
              SizedBox(height:40),
              Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                // Title entry field
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Food Waste Amount', border: OutlineInputBorder()),
                  
                  // Store title and date/time in new journal object
                  onSaved: (value) {
                    postFields.amount = value;
                    final DateTime currentTime = DateTime.now();
                    // Formats date to acceptable database time/date format
                    final String formatted = currentTime.toIso8601String();                 
                    postFields.dateTime = formatted;
                    
                    // Get longitutde and latitude values of post
                    postFields.longitude = locationData.longitude;
                    postFields.latitude = locationData.latitude;
                  },                
                  // The validator ensures amount was entered
                  validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter amount of food waste';
                      } return null;
                    },),
                  SizedBox(height:10),
         
                  ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid
                      if (formKey.currentState.validate()) {
                        // If valid entry, save and submit data and go back to main screen
                        formKey.currentState.save();

 
                    Navigator.of(context).pop();              
                    }
                  },
                  child: Text('Save'),
              )
            ]
         )
        ),

              // RaisedButton(
              //   child: Text('Post it'),
              //   onPressed: (){

              //   })
            ],
          ),
        ),
      );
    }
  }
}