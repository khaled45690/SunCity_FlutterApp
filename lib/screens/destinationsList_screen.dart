import 'package:flutter/material.dart';

class DestinationsListScreen extends StatefulWidget {

  @override
  _DestinationsListScreenState createState() => _DestinationsListScreenState();
}

class _DestinationsListScreenState extends State<DestinationsListScreen> {
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
