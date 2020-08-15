import 'package:SunCity_FlutterApp/models/Provider_File.dart';
import 'package:SunCity_FlutterApp/screens/hotelsList_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelCarousel extends StatelessWidget {

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  @override
  Widget build(BuildContext context) {
     var globalProvider = Provider.of<GlobalProvider>(context);
    if(globalProvider.topHotels != null) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'أفضل الفنادق',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                
             onTap: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HotelsListScreen()),
            );
            
            
            },
                child: Text(
                  'مشاهدة الكل',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
              itemCount: globalProvider.topHotels.length,
              //itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                Map topHotel = globalProvider.topHotels[index];
               // Hotel hotel = hotels[index];
                return GestureDetector(

                    onTap: () => {

                       globalProvider.getTopHotels()
                        // Navigator.of(context).pushNamed(HotelsListScreen.routeName);
                    }
              
                  ,

                    child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 240.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height: 120.0,
                            width: 240.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      topHotel["hotelName"].toString(),
                                    //  '${topHotel["hotelName"].toString()}',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      topHotel["cityName"].toString(),
                                     //'${topHotel["cityName"].toString()}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: .1),
                                    Text(
                                      topHotel["pricePerNight"].toString(),
                                    // '${topHotel["pricePerNight"]}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                               _serverUrl + topHotel["hotelMainImage"].toString(),
                              height: 180.0,
                              width: 220.0,
                              //image: AssetImage(hotel.imageUrl),
                              fit: BoxFit.cover,
                            ),
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
