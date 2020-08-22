
import 'package:flutter/material.dart';

class SeeAllHotelsScreen extends StatefulWidget {
  static const routeName = '/SeeAllHotelScreen';

  @override
  _SeeAllHotelsScreenState createState() => _SeeAllHotelsScreenState();
}

class _SeeAllHotelsScreenState extends State<SeeAllHotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('All Hotels screen'),
        ),

    )
    
    );
  }
}
