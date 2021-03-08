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
 
  
  
  // Retrieve journal entries from database
  void initState(){
    super.initState();
    retrieveLocation();
    //loadJournal();
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
        if (snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0){
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
            var appPost = snapshot.data.docs[index];
            return ListTile(
              title: Text(appPost['Amount'].toString() ),
              //subtitle: Text(userJournal[1] ),
              onTap: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) {                
                    return DetailedEntries(newEntry: appPost);} 
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
  
  // // Determines device orientation and desired build
  // Widget build(BuildContext context){    
  //   if (locationData == null){
  //     return Center(child: CircularProgressIndicator(),);
  //   }
  //   else{
  //     return layoutBuildDecider(context);
  //   }
    
  // }

  // // Builds widgets per device orientation
  // Widget layoutDecider (BuildContext context, BoxConstraints constraints) =>
  // constraints.maxWidth < 500? verticalLayout(context) : horizontalLayout(context);

  final userJournal = ['Latitutde: ', 'Longitude: '];

  // Determines whether to load 'loading' page or list of entries page
  Widget layoutBuildDecider(BuildContext context)  {
    // If no data yet from database, load 'loading' page in the interim 
    return (userJournal == null ) ? loadPage(context) : loadList(context);   
  } 

  // Widget to display list of journal entries
  
  
  Widget loadList(BuildContext context){    
      return ListView.separated(
        // itemCount: userJournal.length,
        itemCount: 1,
        separatorBuilder:  (BuildContext context, int index) => Divider(), 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(userJournal[0] + '${locationData.latitude}'),
            subtitle: Text(userJournal[1] + '${locationData.longitude}'),
            onTap: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) {                
                  return DetailedEntries(newEntry: userJournal);} 
                ),
            );},
          );
      });
  }
 
}

