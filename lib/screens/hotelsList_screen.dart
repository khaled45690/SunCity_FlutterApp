
import 'package:flutter/material.dart';

class HotelsListScreen extends StatefulWidget {

  @override
  _HotelsListScreenState createState() => _HotelsListScreenState();
}

class _HotelsListScreenState extends State<HotelsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Under Construction Page'),
        ),

    )
    
    );
  }
}
