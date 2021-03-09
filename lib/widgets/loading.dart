import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Widget for 'loading' page. Generates loading animation while waiting for data 
// to be established in Cloud Firebase database or waiting to receive data from database
Widget loading(BuildContext context){    
  return new Scaffold(
    appBar: AppBar(
    title: Text('Wasteagram' ),
          centerTitle: true,),
          body: 
          Center(child: CircularProgressIndicator(),),          
    );    
}
