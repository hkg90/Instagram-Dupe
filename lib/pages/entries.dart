import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  LocationData locationData;

  // Retrieve location data from device
  void initState(){
    super.initState();
    retrieveLocation();
  }
    
  // Gets location data from phone device
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
  }
  
  Widget build(BuildContext context){
    return     
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot) {
        //Checks to see if snapshot data has been received or if there is no data yet in database
        if (snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0){
          // Calculates total sum of amounts of entries in database. 
          // Reference source: I used the example code solutio that was discussed in this post: https://stackoverflow.com/questions/58165991/flutter-firestore-calculations-not-working and modified it for my program
          final sum = snapshot.data.docs.fold(0, (total, index) => total + int.parse(index['quantity']));
          
          // Returns listView widget of all entries
          return new Scaffold(
            appBar: AppBar(
            title: Text('Wasteagram - Total: ' + sum.toString()),
            centerTitle: true,),
            body: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
              var appPost = snapshot.data.docs[index];
              return Semantics(
                  label: 'This clickable widget is used to allow the user to display a detailed entry page of this post.',
                  button: true,
                  enabled: true,
                  onTapHint: 'Clicking a tile will open a new page that displays a detailed entry of this Wasteagram post.',
                  child: ListTile(
                  // Formats date to weekday month day year
                  title: Text(DateFormat.yMMMMEEEEd().format(appPost['date'].toDate()) ),
                  // Displays entry's amount
                  trailing: Text(appPost['quantity'].toString()),
                  
                  // If user clicks on entry, widget will display detailed entry
                  onTap: () {Navigator.push(
                      context, MaterialPageRoute(builder: (context) {                
                        return DetailedEntries(entryData: appPost);} 
                      ),
                  );},
                ),
              );
            }
          ),);
        }
        // If there are no entries in Cloud Firestore, then loading page is displayed
        // until data has been added and can be displayed
        else{
          return loading(context);}
      },
    );
  }
}
