import 'package:flutter/material.dart';

class HotelDetailsScreen extends StatefulWidget {
  static const routeName = '/HotelsDetailsScreen';
  final String hotelId;
  final String hotelImage;

  HotelDetailsScreen({this.hotelId, this.hotelImage});

  @override
  _HotelDetailsScreenState createState() => _HotelDetailsScreenState(hotelId : this.hotelId, hotelImage: this.hotelImage);

}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  
  final String hotelId;
  final String hotelImage;
  _HotelDetailsScreenState({this.hotelId, this.hotelImage});
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(' hotel Details screen'),
        ),

    )
    
    );
  }
}
