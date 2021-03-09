import 'package:location/location.dart';
import 'package:flutter/services.dart';

LocationData locationData;  
var locationService = Location();

// Class contains functions that retrieve the current location of the device and 
// ensure that user's location services permissions are enabled (if not allowed/ 
// enabled by user, returns error message).
class FindLocation {
Future retrieveLocation() async {
    try {
      // Determine if enabled
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return null;
        }
      }

      // Determine if permission approved
      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }  
    // Return location data
    return await getNewLocation();
  }

  // Determines location data
  Future getNewLocation() async {
  locationData = await locationService.getLocation();
  return locationData;
  }
}