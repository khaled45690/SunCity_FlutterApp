import 'package:flutter/material.dart';

class SeeAllCitiesScreen extends StatefulWidget {
  static const routeName = '/SeeAllCitiesScreen';

  @override
  _SeeAllCitiesScreenState createState() => _SeeAllCitiesScreenState();
}

class _SeeAllCitiesScreenState extends State<SeeAllCitiesScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
           
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('All cities screen'),
        ),

    )
    
    );
}
}