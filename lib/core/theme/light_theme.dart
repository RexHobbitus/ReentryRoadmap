import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Theme
const Color _lightScaffold = Color(0xFFF7F4F2);
const Color _lightSurface = Color(0xFFFFFFFF);
const Color _lightPrimary = Color(0xFF4F3422);
const Color _lightSecondary = Color(0xFF9BB168);
const Color _lightOnSurface = Color(0xFF002911);
const Color _lightOnPrimary = Color(0xFFFFFFFF);
const Color _lightOnSecondary = Color(0xFFFFFFFF);
const Color _lightTertiaryColor = Color(0xFF767575);


final ThemeData LIGHT_THEME=ThemeData(
  primaryColor: _lightPrimary,
  useMaterial3: false,
  scaffoldBackgroundColor: _lightScaffold,
  fontFamily:'CircularStd',
  textTheme: const TextTheme(
    displayLarge:TextStyle(color: Colors.black),
    displaySmall:TextStyle(color: Colors.black),
    displayMedium:TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // Customize the elevated button's appearance
      backgroundColor: _lightPrimary, // Set the background color
      foregroundColor: _lightOnPrimary, // Set the text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        // Set the button's border radius
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: _lightScaffold,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: _lightPrimary,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      )
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _lightPrimary,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  colorScheme: const ColorScheme.light(
      surface: _lightSurface,
      onSurface: _lightOnSurface,
      primary: _lightPrimary,
      onPrimary: _lightOnPrimary,
      secondary: _lightSecondary,
      onSecondary: _lightOnSecondary,
      tertiary: _lightTertiaryColor
  ),
);
