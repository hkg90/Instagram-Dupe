import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

// Widget for 'loading' page (when waiting for data back from 
  // database query)
  Widget loadPage(BuildContext context){    
      return Column(
        children: [
            Text('Loading', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Center(child: CircularProgressIndicator(),),
            Text('Latitute:'),
            Text('Longitutde')
        ],);    
  }