import 'package:SunCity_FlutterApp/models/Provider_File.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TourDetailsScreen extends StatefulWidget {
  static const routeName = '/TourDetailsScreen';
  final String tourId;
  final String tourImage;

  TourDetailsScreen({this.tourId , this.tourImage});

  @override
  _TourDetailsScreenState createState() => _TourDetailsScreenState(tourId : this.tourId, tourImage: this.tourImage);
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  final String tourId;
  final String tourImage;

  _TourDetailsScreenState({this.tourId , this.tourImage});

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
      stars.trim();
    }
    return Text(stars);
  }

  @override

  Widget build(BuildContext context) {
     
    //  final cityData =  Provider.of<City>(context);
    //  final cities = cityData.items;

    final cityId = ModalRoute.of(context).settings.arguments as String;
    final loadeddCityData = Provider.of<GlobalProvider>(context);//.findById(destinId);
    // final loadeddestinationDataactivity=  Provider.of<Activities>(context).findByIId(destinId);

    return Scaffold(
  //    appBar: AppBar(title: Text('${loadeddCityData.getToursByCityId()}')),
      body: ListView.builder(
          itemCount: 1,
          // Provider.of<Destinations>(context).items.length,
          itemBuilder: (BuildContext ctx, int index) {

            //     Activity activity = widget.destination.activities[index];

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      // child: Image.network(
                       
                      //   _serverUrl + loadeddCityData["mainTourImage"].toString(),

                      //   width: 1100.0,
                      //   fit: BoxFit.cover,
                        
                      //   //_serverUrl + loadeddestinationDat["mainTourImage"].toString(),
                        
                      //   //loadeddestinationDat.tours[index].),
                            
                      // ),

                      
                      // child: Image.network(
                      //          _serverUrl + loadeddCityData["mainHotelImage"].toString(),
                      //         height: 180.0,
                      //         width: 220.0,
                      //         //image: AssetImage(hotel.imageUrl),
                      //         fit: BoxFit.cover,
                      //       ),




                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(100, 30, 1, 50),
                  //   child: Text(loadeddestinationDat.activities[index].name,style: TextStyle(fontSize:55,fontWeight: FontWeight.w600,),
                  //   ),

                  //   ),
                  //   Padding(
                  //     padding:EdgeInsets.fromLTRB(130, 10, 1, 5) ,
                  //     child: _buildRatingStars(loadeddestinationDat.activities[index].rating )),
                  //     Padding(
                  //     padding:EdgeInsets.fromLTRB(150, 10, 1, 5) ,
                  //     child: Text('Stars',style: TextStyle(fontSize:40,fontWeight:FontWeight.bold) ))
                  Card(
                    child: ListTile(
                      title: (Text('',
                       // loadeddCityData.toursData[index].name,
                        style: TextStyle(fontSize: 50),
                      )),
                      subtitle: Text('',
                       //   loadeddCityData.toursData[index].startTimes.toString(),
                          style: TextStyle(fontSize: 25)),
                      trailing: Text('',
                          //'\$${loadeddCityData.toursData[index].price.toString()}',
                          style: TextStyle(fontSize: 50)),
                    ),
                  )
                ]);
          }),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
