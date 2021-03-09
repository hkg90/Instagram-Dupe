import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/get_location.dart';
import 'package:wasteagram/models/proccess_image.dart';


// Class acts as DTO for new entry post form data
class PostEntryFields {
  String amount;
  DateTime date;
  String longitude;
  String latitude;
  String url;
}

// Widget generates prompt for use to select an image from camera gallery and
// processes generated form to Cloud Firebase database
class NewEntry extends StatefulWidget {
  final LocationData location;
  NewEntry({this.location});
  
  @override
  NewEntryState createState() => NewEntryState();
}

class NewEntryState extends State<NewEntry> {
  PickedFile image;
  final formKey = GlobalKey<FormState>();
  final postFields = PostEntryFields();
  var imageURL;
  
  // Processes user's selected picture and converts it into a URL via Cloud storage
  void processImage() async {    
    final imageResult = await ConvertImage().getImage();
    image = imageResult[0];
    imageURL = imageResult[1];
    // Get location data
    locationData = await FindLocation().retrieveLocation();    
    // Update app state
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context){
    // If no image has been selected, open camera gallery and process
    // selected image into a URL
    if (image == null) {
      processImage();
      // While processing image, if not yet complete then display loading animation
      return Center(child: CircularProgressIndicator(),);
    } 
    // Once image has loaded, load form page to post image to wasteagram
    else {
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
                      Semantics(
                        label: 'This text form widget allows the user to submit a quantity of the amount of food wasted in their post.',
                        button: true,
                        enabled: true,
                        onTapHint: "This field is for entering in how much food was wasted. The quantity will be submitted to Wasteagram's database.",
                        // Food quantity wasted entered in this text field.
                        child: TextFormField(
                          autofocus: true,
                          // Reference source: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter 
                          // I used the example code in this article to ensure that the user can only enter numbers into the field
                          // and cannot enter commas or decimal points (to ensure entries are only of type int)
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                          labelText: 'Enter Food Waste Amount', border: OutlineInputBorder()),
                          
                          // Store amount, date, latitude, longitude and URL of entry
                          onSaved: (value) {
                            postFields.amount = value;
                            // Get current date/ time
                            final DateTime currentDate = DateTime.now();
                            postFields.date = currentDate;                            
                            // Get longitutde and latitude values of post
                            postFields.longitude = locationData.longitude.toString();
                            postFields.latitude = locationData.latitude.toString();
                            //Assign URL from Cloud Firebase
                            postFields.url = imageURL;},                
                                        
                          // The validator ensures amount is not empty 
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
                          // Button widget to submit form
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