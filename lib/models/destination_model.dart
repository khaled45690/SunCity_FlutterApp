
import './activity_model.dart';

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
imageUrl: 'assets/Images/forest_waterfall_cave-wallpaper-1366x768.jpg',
city: 'paris',
country: 'France',
description: 'Test',
activities: activities,
),


Destination(
imageUrl: 'assets/Images/Godafoss_Iceland .jpg',
city: 'Rome',
country: 'Italy',
description: 'Test',
activities: activities,
),


Destination(
imageUrl: 'assets/Images/hd-wallpapers-big-full-moon-image-free-desktop-nature-landscapes-photo-moon-wallpaper-hd.jpg',
city: 'Sydney',
country: 'Australia',
description: 'Test',
activities: activities,
),


];