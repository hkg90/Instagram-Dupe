import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:wasteagram/pages/create_entry.dart';
import 'pages/entries.dart';


// Widget loads 'loading' page if no database entries are present or 
// generates listview of Wasteagram entries via data from Cloud Firebase database
class App extends StatefulWidget  {

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  // Firebase Analaytics initalizer
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      navigatorObservers: <NavigatorObserver>[observer],
      home: Builder(
          builder: (context) {
            return new Scaffold(
              body: 
                // Generate widget for displaying list of posts (or loading page when applicable)
                AppPosts(),
                // Button for adding new post to Wasteagram
                floatingActionButton: Semantics(
                  label: "This button widget allows the user to access their device's gallery and select a photo for a new Wasteagram entry post.",
                  button: true,
                  enabled: true,
                  onTapHint: 'Select an iamge',
                  child: FloatingActionButton(
                    child: Icon(Icons.camera_alt),
                    onPressed: () {
                      analytics.logEvent(name: 'new_post', parameters: null);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewEntry(),
                      settings: RouteSettings(name: 'NewPostPage')));}
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
          } 
      )
    );
  }
}
