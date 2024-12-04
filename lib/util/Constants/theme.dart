import 'package:flutter/material.dart';

class MyTheme{
  MyTheme ._();
 static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.blue,
  fontFamily:'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
 );

 static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    fontFamily: 'Poppins'
 );
}