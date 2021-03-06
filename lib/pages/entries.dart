import 'package:flutter/cupertino.dart';
//import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wasteagram/widgets/display_single_entry.dart';
import 'package:wasteagram/widgets/loading.dart';


// Generates listview of all journal entries and loads 'Loading' page
// if async functions have not yet received data from database.
class JournalEntries extends StatefulWidget {

  @override
  JournalEntriesState createState() => new JournalEntriesState();
}

class JournalEntriesState extends State<JournalEntries> {
 
  // var userJournal;
  final String apptitle = 'Journal Entries';
  
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

  
  // // Retreives journal entries from database
  // Future loadJournal() async {
  //   // Open database file
  //   Database database = await openDatabase(
  //     'journal.sqlite3.db', version: 1, onCreate: (Database db, int version) async{
  //       var query = await processSQLData();
  //       await db.execute(query);
  //     });
    
  //   // Retrieve data from sql database
  //   List<Map> databaseEntries = await database.rawQuery('SELECT * FROM journal_entries');  

  //   // Create journal object to store database entries in a list
  //   final listEntries = databaseEntries.map((record){
  //     return Entries(
  //       title: record['title'],
  //       body: record['body'], 
  //       rating: record['rating'],
  //       dateTime: DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(record['date'])));
  //     }).toList();
    
  //   setState(() {
  //     userJournal = listEntries;
  //   });
  // }

  @override 
  // Rebuild widgets when changes made/ new journal entry added
  void didUpdateWidget(JournalEntries oldWidget) {
    super.didUpdateWidget(oldWidget);
    //loadJournal();
  }
  
  // Determines device orientation and desired build
  Widget build(BuildContext context){    
    if (locationData == null){
      return Center(child: CircularProgressIndicator(),);
    }
    else{
      return layoutBuildDecider(context);
    }
    
  }

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

