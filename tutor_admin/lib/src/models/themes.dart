import 'package:flutter/material.dart';

class MyThemes {
  ThemeData lightTheme = ThemeData.light().copyWith(
    dividerColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[350],
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: Colors.black,
      elevation: 5,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
  ThemeData darkTheme = ThemeData.dark().copyWith(
    dividerColor: Colors.grey[250],
    scaffoldBackgroundColor: const Color.fromARGB(255, 41, 45, 62),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: Colors.black,
      elevation: 5,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
