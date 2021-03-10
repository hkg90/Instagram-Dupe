import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';

// Executes app
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  
  
  // Launch app
  runApp(App());
}