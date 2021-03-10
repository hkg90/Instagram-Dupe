import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';

// Executes app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Cloud Firebase in app
  await Firebase.initializeApp();  
  // Initialize Crashlytics in app
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);    
  // Launch app
  runApp(App());
}