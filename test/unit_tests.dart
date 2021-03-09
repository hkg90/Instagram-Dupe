import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:flutter/widgets.dart';

import 'package:wasteagram/models/get_location.dart';
import 'package:wasteagram/models/proccess_image.dart';


// Running unit_tests.dart will run two unit tests and test Wasteagram App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  group('App Model tests', () {
    // Tests location getter function
    test('Determine if function in class FindLocation returns the correct longitude and latitude.', () async {
    final locate = FindLocation();
    
    final LocationData locationData = await locate.getNewLocation();
    print('Latitude is: '+ locationData.latitude.toString());
    print('Longitude is: '+locationData.longitude.toString());
    expect(locationData.longitude, -122.0840312);
    expect(locationData.latitude, 37.4219834);
    });

    // Tests if function to convert image from file to URL via Cloud Storage is valid
    test('Determine if function in class ConvertImage returns a valid URL from image conversion process.', () async {
    final image = ConvertImage();
    final result = await image.getImage();
    print('Converted URL is: '+ result[1].toString());
    expect(result[1], contains('http'));
    });
  });   
}
