import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';


// Executes app
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  // Launches app
  //runApp(App(preferences: await SharedPreferences.getInstance()));
  runApp(App());
}