import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/fonts.gen.dart';

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: Colors.black,
  iconTheme: const IconThemeData().copyWith(color: Colors.white),
  fontFamily: FontFamily.montserrat,
  colorScheme: ColorScheme.dark(
    background: const Color(0xFF121212),
    secondary: const Color(0xFF1DB954),
  ),
  textTheme: TextTheme(
    displayMedium: const TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 12.0,
      color: Colors.grey[300],
      fontWeight: FontWeight.w500,
      letterSpacing: 2.0,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[300],
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[300],
      letterSpacing: 1.0,
    ),
  ),
);
