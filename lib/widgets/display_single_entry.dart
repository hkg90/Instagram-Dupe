import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';



// Widget to display single detailed journal entry (title, body, rating, date)
class DetailedEntries extends StatelessWidget {
final entryData;

DetailedEntries ({this.entryData});
 @override 
  Widget build(BuildContext context){    
    return Builder(
      builder: (context) {
        return new Scaffold(
          appBar: 
          AppBar(
            title: Text('Wasteagram'),
          ),
          
          body: Center(
            
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DateFormat.yMMMMEEEEd().format(entryData['Date'].toDate()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                  SizedBox(height:40),
                  Image.network(entryData['URL'].toString()),
                  SizedBox(height:40),
                  Text('Items: ' + entryData['Amount'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  SizedBox(height:40),
                  Text('Location: (' + entryData['Latitude'].toString() + ', ' + entryData['Longitude'] + ')', style: TextStyle(fontSize: 18)),
                ],  
         ),
            ),
          ) 
        );
      } 
    );
  }

}
