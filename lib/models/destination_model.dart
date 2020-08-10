
import '../models/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({

    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities = [

  Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'المعموره',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),
   Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'description',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),
  
   Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'description',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),

   Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'description',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),
   Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'description',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),
   Activity(
    imageUrl : 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
    name : 'description',
    type :'walking' ,
    startTimes :['9:00 am' , '11.00 am'],
    rating : 5,
    price : 30
  ),

];


List<Destination> destinations = [


Destination(
imageUrl: 'assets/Images/alex.jpg',
city: 'paris',
country: 'الاسكندريه',
description: 'alex the city where the sea is amazing',
activities: activities,
),


Destination(
//imageUrl: 'assets/Images/Godafoss_Iceland .jpg',
imageUrl: 'assets/Images/geza.jpg',

city: 'Rome',
country: 'الجيزه',
description: 'the capital of egypt',
activities: activities,
),


Destination(
//imageUrl: 'assets/Images/hd-wallpapers-big-full-moon-image-free-desktop-nature-landscapes-photo-moon-wallpaper-hd.jpg',
imageUrl: 'assets/Images/cairo.jpg',

city: 'Sydney',
country: 'الفاهره',
description: 'geza is the city that famous for pyramids',
activities: activities,
),


];