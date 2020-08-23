import 'package:SunCity_FlutterApp/widgets/appDrawer_widget.dart';
import 'package:SunCity_FlutterApp/widgets/city_Carousel.dart';
import 'package:SunCity_FlutterApp/widgets/hotel_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  int _currentTab = 0;
  // List<IconData> _icons = [
  //   FontAwesomeIcons.hiking,
  //   FontAwesomeIcons.biking,
  //   FontAwesomeIcons.walking,
  //   FontAwesomeIcons.biking,
  //   FontAwesomeIcons.walking,
  // ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).accentColor
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
//         child: Icon(
//           _icons[index],
//           size: 25.0,
//           color: _selectedIndex == index
//               ? Theme.of(context).primaryColor
//               : Color(0xFFB4C1C4),
//         ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 120.0, right: 20.0),
              child: Text(
                'إختر وجهتك',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 0.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: _icons
            //       .asMap()
            //       .entries
            //       .map(
            //         (MapEntry map) => _buildIcon(map.key),
            //       )
            //       .toList(),
            // ),
            SizedBox(height: 15.0),
            CityCarousel(),
            SizedBox(height: 10.0),
            HotelCarousel(),
          ],
        ),
      ),
    );
  }
}
