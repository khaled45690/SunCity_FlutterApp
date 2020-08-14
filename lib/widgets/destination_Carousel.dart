import 'package:SunCity_FlutterApp/models/destination_model.dart';
import 'package:SunCity_FlutterApp/screens/destination_screen.dart';
import 'package:SunCity_FlutterApp/screens/destinationsList_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:SunCity_FlutterApp/models/Provider_File.dart';

class DestinationCarousel extends StatelessWidget {

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  @override
  Widget build(BuildContext context) {
    var globalProvider = Provider.of<GlobalProvider>(context);
    if(globalProvider.globalData != null) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'أفضل المدن',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DestinationsListScreen()),
                    );
                  },
                  child: Text(
                    'مشاهدة الكل',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 300.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: globalProvider.globalData.length,
                itemBuilder: (BuildContext context, int index) {
                  Map destination = globalProvider.globalData[index];
                  return GestureDetector(
                    onTap: () =>
                    {
                      globalProvider.getMainData(),
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (_) =>
//                            DestinationScreen(destinations: destination),
//                      ),
//                    )
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: 210.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: 15.0,
                            child: Container(
                              height: 120.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        '${destination["toursCount"].toString()} عدد الرحلات',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2),
                                      ),
                                      Text(
                                        '${destination["description"].toString()}',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                  )
                                ]),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                   _serverUrl + destination["image"].toString(),
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                                Positioned(
                                  left: 10.0,
                                  bottom: 10.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        destination["cityName"].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 10.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            destination["countryName"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
        ],
      );
    }
    else{
      return Container();
    }
  }
}
