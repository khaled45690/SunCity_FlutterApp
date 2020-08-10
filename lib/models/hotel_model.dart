import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Hotel{
int id;
String imageUrl;
String name ;
String address;
int price;

Hotel({
  this.imageUrl,
  this.name,
  this.address,
  this.price,
});

}

final List<Hotel> hotels = [
  
  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق كيليوباترا',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق لاجينسي',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق  توليب',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق فورسيزون',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق النجوم',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق الشاطبي',
    address: 'Test',
    price: 100,
  ),

  Hotel(
    imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name: 'فندق البحريه',
    address: 'Test',
    price: 100,
  ),
  
];


