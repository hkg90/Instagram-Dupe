import 'package:flutter/cupertino.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Widget for 'loading' page. Generates loading animation while waiting for data 
// to be established in Cloud Firebase database or waiting to receive data from database
Widget loading(BuildContext context){    
  return new Scaffold(
    appBar: AppBar(
    title: Text('Wasteagram' ),
          centerTitle: true,),
          body: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Center(child: CircularProgressIndicator()),
            // Button is used for purposefully making the app Crash to get
            // crash report from Crashlytics
            RaisedButton(
              child: Text('Crash App!'),
              onPressed: () {FirebaseCrashlytics.instance.crash();})
          ],));          

}
