// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';


// //import 'package:project4_journal/models/process_data.dart';

// import 'package:wasteagram/app.dart';
// import 'package:location/location.dart';


// // Form Widget that constructs the form for entering in new user journal entry
// // into the journal and databse
// class NewEntry extends StatefulWidget {
//   final LocationData location;
  
//   NewEntry({this.location});

//   @override
//   _NewEntryState createState() => _NewEntryState();
// }

// class _NewEntryState extends State<NewEntry> {
//   final String apptitle = 'New Entry';

//   @override 
//   Widget build(BuildContext context){
//     return Scaffold(       
//         appBar: 
//         AppBar(
//           title: Text(apptitle),
//           // actions: [Builder( builder: (context) =>
//           //   IconButton(
//           //     icon: const Icon(Icons.settings),
//           //     onPressed: () {
//           //       Scaffold.of(context).openEndDrawer();
//           //     },
//           //   ),
//           // ),]
//         ),
//         body: 
//             // Builds form widget
//             JournalEntryForm()
//       );
//   }
// }

// // A class that stores and creates a DTO for new journal entries
// class PostEntryFields {
//   String longitude;
//   String latitude;
//   String date;
//   int amount;
//   // String toString(){
//   //   return 'Longitude: $title, Latitude: $body, Date: $dateTime, Amount: $rating';
//   // }  
// }

// // Form component of NewEntry Widget
// class JournalEntryForm extends StatefulWidget {
//   @override
//   JournalEntryFormState createState() {
//     return JournalEntryFormState();
//   }
// }

// class JournalEntryFormState extends State<JournalEntryForm> {

//   final formKey = GlobalKey<FormState>();
//   // DTO for storing new journal entry data
//   //final journalEntryFields = JournalEntryFields();
  
//   @override
//   Widget build(BuildContext context) {
//     //AppState state = context.findAncestorStateOfType<AppState>();

//     // Builds a Form widget using the formKey created above
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//               // Title entry field
//               TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   labelText: 'Title', border: OutlineInputBorder()),
                
//                 // Store Picture
//                 onSaved: (value) {
//                   journalEntryFields.title = value;
//                   final String currentDate = DateFormat.yMMMMd().format(DateTime.now());
                  
                  
                  
//                   // Formats date to acceptable database time/date format
//                   //final String formatted = currentTime.toIso8601String();                 
//                   journalEntryFields.date = currentDate;
//                 },                
//                 // The validator ensures entered text is valid
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter an entry title';
//                   }
//                   return null;
//                 },),
//                 SizedBox(height:10),
              
//                 // Body entry field
//                 TextFormField(
//                   autofocus: true,
//                   decoration: InputDecoration(
//                     labelText: 'Body', border: OutlineInputBorder()),                  
//                   // Store body content in new journal object
//                   onSaved: (value) {
//                     journalEntryFields.body = value;},
//                   // The validator ensures entered text is valid
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Please enter the entry's body content";
//                     }
//                     return null;
//                   },),
//                 // Spacing widget
//                 SizedBox(height:10),
                
//                 // Rating entry field
//                 TextFormField(
//                   autofocus: true,
//                   decoration: InputDecoration(
//                     labelText: 'Rating', border: OutlineInputBorder()),                  
//                   // Store rating in new journal object
//                   onSaved: (value) {
//                     journalEntryFields.rating = int.parse(value);
//                   },                  
//                   // The validator ensure entered rating is valid
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter your number rating';
//                     } else if (int.parse(value) > 4 || int.parse(value) < 1) {
//                       return 'Please ensure rating is within range: 1-4';
//                     }
//                     return null;
//                   },),
//                 // Spacing widget
//                 SizedBox(height:10),
                
//                 ElevatedButton(
//                   onPressed: () async {
//                     // Validate returns true if the form is valid
//                     if (formKey.currentState.validate()) {
//                       // If valid entry, save and submit data and go back to main screen
//                       formKey.currentState.save();
                      
//                       //Send data to Cloud Firebase
//                       FirebaseFirestore.instance.collection('posts').add({
                        
//                       });

  
//                   // Close database file
//                   // await database.close();
//                   Navigator.of(context).pop();              
//                   }
//                 },
//                 child: Text('Save'),
//             )
//           ]
//        )
//       ),
//     );
//   }


// }

