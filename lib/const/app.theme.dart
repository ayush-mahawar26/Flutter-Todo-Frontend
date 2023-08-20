import 'package:flutter/material.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
        textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontSize: 20,
              fontFamily: "assets/fonts/Poppins-Regular.ttf",
            ),
            bodyMedium: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(
                fontSize: 30,
                fontFamily: "assets/fonts/Poppins-Regular.ttf",
                fontWeight: FontWeight.bold)));
  }
}
