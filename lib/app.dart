//import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'pages/entries.dart';
import 'pages/new_entry.dart';
import 'package:wasteagram/widgets/loading.dart';

// Creates widgets depending on set user preferences (theme and # journal entries)
class App extends StatefulWidget  {
  // This widget is the root of the application.
  //final SharedPreferences preferences;

  //App({Key, key, @required this.preferences}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  //var theme = true;
  var entriesSetting = 1;
  var userJournal;
  var themeState = true;
  var entriesState = 1;


  // Getter for retreiving current preferences saved theme value (if no value saved, default to True)
  //bool get themeSetting => widget.preferences.getBool(THEME_SETTING_KEY) ?? true;

  // Getter for retreiving current preferences saved theme value (if no value saved, default to 0)
  //int get entriesSetting => widget.preferences.getInt(ENTRIES_KEY) ?? 0;
  
  void initState(){
    super.initState();
    // Determines number of entries currently written in journal. If 0, 
    // welcome page will load, else journal entries page will load
    //loadJournal();
  }

  // Loads journal data from sqflite database
  // void loadJournal() async {   
  //   // Open database file
  //   Database database = await openDatabase(
  //     'journal.sqlite3.db', version: 1, onCreate: (Database db, int version) async{
  //       var query = await processSQLData();
  //       await db.execute(query);
  //     });
  
    // Retrieve data from sql database
    //List<Map> databaseEntries = await database.rawQuery('SELECT * FROM journal_entries');

    // Create journal object to store database entries into a list
    // final listEntries = databaseEntries.map((record){
    //   return Entries(
    //     title: record['title'],
    //     body: record['body'], 
    //     rating: record['rating'],
    //     dateTime: DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(record['date'])));
    // }).toList();
    
    // // Set state for journal
    // setState(() {
    //   userJournal = listEntries;   
    // });
  // }

  // // Notifier variable, if variable value is changed UI theme will update
  // ValueNotifier<bool> themeState = ValueNotifier<bool>(true);

  // // Notifier variable, if variable value is changed page will switch from 'welcome'
  // // display to list of journal entries
  // ValueNotifier<int> entriesState = ValueNotifier<int>(0);
  
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
                    // Adds settings drawer
                    //endDrawer: SettingsDrawer(),
                    appBar: 
                    AppBar(
                        // Determmines title display text
                        title: Text('Wasteagram'),
                        // actions: [Builder( builder: (context) =>
                        //   // Designates icon for settings drawer
                        //   IconButton(
                        //     icon: const Icon(Icons.settings),
                        //     onPressed: () {
                        //       Scaffold.of(context).openEndDrawer();},
                        //   ),
                        // ),]
                    ),
                    body: 
                      // Determines which page to display (welcome or list of entries)
                      (entriesSetting == 0) ? loadPage(context): JournalEntries(),
                      // Contains widget for floating action new journal entry form button
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.camera),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewEntry()));}
                      ),
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                    );
                } 
            )
          );
  }
}
