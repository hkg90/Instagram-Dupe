import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/get_location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';



class PostEntryFields {
  String amount;
  DateTime date;
  String longitude;
  String latitude;
  String url;
}

class CameraScreen extends StatefulWidget {
  final LocationData location;
  CameraScreen({this.location});
  
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  PickedFile image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final postFields = PostEntryFields();
  var imageURL;
  void getImage() async {
    // Allows user to pick an image from emulator's default gallery images
    image = await picker.getImage(source: ImageSource.gallery);
    locationData = await FindLocation().retrieveLocation();
    // Send image to Cloud Firestore - 'file_name' uses the date time stamp to create a 
    // unique file name to store the file in the Cloud
    final fileName = DateTime.now();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName.toString()+'.jpg');
    
    // Execute upload task to send image to Cloud
    UploadTask newTask = storageReference.putFile(File(image.path));
    imageURL = await (await newTask).ref.getDownloadURL();
    print(imageURL);
    

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context){
    if (image == null) {
      getImage();
      return Center(child: CircularProgressIndicator(),);
    } else {
      // Once have image loaded, display image and new button to post image to wasteagram
      return Scaffold(
resizeToAvoidBottomPadding: false,
        appBar: 
          AppBar(
            title: Text('New Post'),
          ),
          body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:40),
                    Image.file(File(image.path)),
                    SizedBox(height:40),
                    Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      // Food quantity wasted entered in this text field.
                      Semantics(
                        label: 'This text form widget allows the user to submit a quantity of the amount of food wasted in their post.',
                        button: true,
                        enabled: true,
                        onTapHint: "This field is for entering in how much food was wasted. The quantity will be submitted to Wasteagram's database.",
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                          labelText: 'Enter Food Waste Amount', border: OutlineInputBorder()),
                          
                          // Store amount, date, latitude, longitude of entry
                          onSaved: (value) {
                            postFields.amount = value;
                            final DateTime currentDate = DateTime.now();
                            postFields.date = currentDate;
                            
                            // Get longitutde and latitude values of post
                            postFields.longitude = locationData.longitude.toString();
                            postFields.latitude = locationData.latitude.toString();

                            //Assign URL from Cloud Firebase
                            postFields.url = imageURL;},                
                                        
                          // The validator ensures amount was entered
                          validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter amount of food waste';
                              } return null;
                            },
                        ),
                      ),
                      SizedBox(height:100),
         
                      SizedBox(
                        width: double.infinity,
                        height: 90,                          
                        child: Semantics(
                          label: 'This button allows the user to submit their entry to the Cloud Firebase database for Wasteagram.',
                          button: true,
                          enabled: true,
                          onTapHint: "Clicking this button will submit a new entry to Wastegram's database",
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid
                              if (formKey.currentState.validate()) {
                                // If valid entry, save and submit data and go back to main screen
                                formKey.currentState.save();

                                //Send data to Cloud Firebase
                              FirebaseFirestore.instance.collection('posts').add({
                                'date': postFields.date,
                                'imageURL': postFields.url,
                                'longitude': postFields.longitude,
                                'latitude': postFields.latitude,
                                'quantity': postFields.amount,
                              });
                            // Return to home page
                            Navigator.of(context).pop();              
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.cloud_upload_outlined, size: 80),) ,
                          ),
                        ),
                      )
                  ]
              )
            ),
          ],
        ),
      );
    }
  }
}