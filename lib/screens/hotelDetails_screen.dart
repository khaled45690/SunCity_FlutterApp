import 'package:flutter/material.dart';

class HotelsDetailsScreen extends StatefulWidget {

  @override
  _HotelsDetailsScreenState createState() => _HotelsDetailsScreenState();
}

class _HotelsDetailsScreenState extends State<HotelsDetailsScreen> {
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
