//import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/pages/create_entry.dart';

import 'pages/entries.dart';
import './widgets/loading.dart';
import './widgets/location.dart';

// Creates widgets depending on set user preferences (theme and # journal entries)
class App extends StatefulWidget  {

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  //var theme = true;
  var entriesSetting = 1;
  var userJournal;
  var themeState = true;
  var entriesState = 1;


  
  void initState(){
    super.initState();
  }

    
  @override
  Widget build(BuildContext context) {
    // Value Listenable builder rebuilds widgets if themeState and/ or entries State 
    // value notifier variable's value is changed
    return MaterialApp(
            // Determmines title display text
            title: 'Wasteagram',
            // Determines theme of app
            theme: ThemeData.dark(),
            home: Builder(
                builder: (context) {
                  return new Scaffold(
                    body: 
                      // Determines which page to display (welcome or list of entries)
                      AppPosts(),
                      // Contains widget for floating action new journal entry form button
                      floatingActionButton: Semantics(
                        label: "This button widget allows the user to access their device's gallery and select a photo for a new Wasteagram entry post.",
                        button: true,
                        enabled: true,
                        onTapHint: 'Select an iamge',
                        child: FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen()));}
                        ),
                      ),
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                    );
                } 
            )
          );
  }
}
