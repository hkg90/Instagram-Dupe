import 'package:flutter/cupertino.dart';
//import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/display_single_entry.dart';
import '../widgets/loading.dart';



// Generates listview of all journal entries and loads 'Loading' page
// if async functions have not yet received data from database.
class AppPosts extends StatefulWidget {

  @override
  AppPostsState createState() => new AppPostsState();
}

class AppPostsState extends State<AppPosts> {
 
  
  
  // Retrieve location data from device
  void initState(){
    super.initState();
    retrieveLocation();
    
  }
  LocationData locationData;
  

  void retrieveLocation() async {
    { 
      var locationService = Location();
      locationData = await locationService.getLocation();
      setState(() {
        
      });
    }
  }

  
  

  @override 
  // Rebuild widgets when changes made/ new journal entry added
  void didUpdateWidget(AppPosts oldWidget) {
    super.didUpdateWidget(oldWidget);
    //loadJournal();
  }
  
  Widget build(BuildContext context){
    return     
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot) {
        //snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0
        if (snapshot. hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0){
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
            var appPost = snapshot.data.docs[index];
            return ListTile(
              title: Text(appPost['Amount'].toString() ),
              //subtitle: Text(userJournal[1] ),
              onTap: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) {                
                    return DetailedEntries(entryData: appPost);} 
                  ),
              );},
            );
            }
        );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
      );
  }
  
 
}

