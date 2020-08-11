import 'package:flutter/material.dart';
import 'dart:io';
class RoundedImageWidget extends StatelessWidget {
  final File imagefile;

  RoundedImageWidget({@required this.imagefile});
  @override
  Widget build(BuildContext context) {
    if (imagefile != null) {
      return Padding(
        padding: const EdgeInsets.only(left : 20),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: Image.file(
            imagefile,
          ).image,
        ),
      );
//      return Image.file(_imageFile);
    } else {
      return  Padding(
        padding: const EdgeInsets.only(left : 20),
        child: CircleAvatar(
          backgroundColor: Color(0xFFF3F5F7),
          radius: 30,
        ),
      );;
    }
  }
}
