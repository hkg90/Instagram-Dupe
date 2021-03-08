import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

// Widget for 'loading' page (when waiting for data back from 
  // database query)
  Widget loading(BuildContext context){    
      return new Scaffold(
              appBar: AppBar(
            title: Text('Wasteagram' ),
            centerTitle: true,
          ),
              body: 
              Center(child: CircularProgressIndicator(),),          
      );    
  }