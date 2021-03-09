import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


// Class contains dart code to process an image selected by the user from the 
// device's gallery and converts it into a URL via Cloud Storage Firebase. 
// Returns converted data to widget.
class ConvertImage {
  PickedFile image;
  final picker = ImagePicker();

  var imageURL;
  
  // Converts image from device into a URL
  Future getImage() async {
    // Allows user to pick an image from emulator's default gallery images
    image = await picker.getImage(source: ImageSource.gallery);
    
    // Send image to Cloud Firestore - 'file_name' uses the date time stamp to create a 
    // unique file name to store the file in the Cloud
    final fileName = DateTime.now();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName.toString()+'.jpg');
    
    // Execute upload task to send image to Cloud
    UploadTask newTask = storageReference.putFile(File(image.path));
    imageURL = await (await newTask).ref.getDownloadURL();
    final result = [image, imageURL];
    return result; 
  }
}