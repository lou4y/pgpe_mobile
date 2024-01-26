import 'package:flutter/material.dart';

const kPrimaryColor =  Color(0xFF478DE0);
 Color kPrimaryLightColor = Color(0xff9d9ef6).withOpacity(0.1);

final gradient = LinearGradient(
 begin: Alignment.topCenter,
 end: Alignment.bottomCenter,
 colors: [
  Color(0xFF73AEF5),
  Color(0xFF61A4F1),
  Color(0xFF478DE0),
  Color(0xFF398AE5),
 ],
 stops: [0.1, 0.4, 0.7, 0.9],
);

const double defaultPadding = 16.0;

final kHintTextStyle = TextStyle(
 color: Colors.white54,
 fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
 color: Colors.white,
 fontWeight: FontWeight.bold,
 fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
 color: kPrimaryColor,
 borderRadius: BorderRadius.circular(10.0),
 boxShadow: [
  BoxShadow(
   color: Colors.black12,
   blurRadius: 6.0,
   offset: Offset(0, 2),
  ),
 ],
);
