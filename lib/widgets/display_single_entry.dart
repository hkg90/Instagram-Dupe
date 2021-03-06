import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



// Widget to display single detailed journal entry (title, body, rating, date)
class DetailedEntries extends StatelessWidget {
final newEntry;

DetailedEntries ({this.newEntry});
 @override 
  Widget build(BuildContext context){    
    return Builder(
      builder: (context) {
        return new Scaffold(
          appBar: 
          AppBar(
            title: Text('example title'),
          ),
          
          body: Center(
            
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
                  
                  Image(image: AssetImage('assets/burrito.jfif'),),
                  Text('number', style: TextStyle(fontSize: 18)),
                ],  
         ),
            ),
          ) 
        );
      } 
    );
  }

}
