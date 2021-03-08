import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';


import 'app.dart';


// Executes app
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Launches app
  //runApp(App(preferences: await SharedPreferences.getInstance()));
  runApp(App());
}