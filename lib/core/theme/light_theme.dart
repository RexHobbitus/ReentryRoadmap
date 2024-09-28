import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/custom_page_transition_builder.dart';

// Light Theme
const Color _lightScaffold = Color(0xFfFFFFFF);

const Color _lightSurface = Color(0xFFFFFFFF);
const Color _lightOnSurface = Color(0xFF151517);

const Color _lightPrimary = Color(0xFF807ED5);
const Color _lightOnPrimary = Color(0xFFFFFFFF);

const Color _lightSecondary = Color(0xFF11404C);
const Color _lightOnSecondary = Color(0xFFFFFFFF);

const Color _lightTertiaryColor = Color(0xff89898A);
const Color _lightOnTertiaryColor = Color(0xFF151517);

const Color _lightTertiaryContainerColor = Color(0xFFBFD4D9);

const Color _lightCardColor = Color(0xFFF6F9FA);

final ThemeData LIGHT_THEME = ThemeData(
  primaryColor: _lightPrimary,
  useMaterial3: false,
  scaffoldBackgroundColor: _lightScaffold,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _lightPrimary,
      foregroundColor: _lightOnPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        // Set the button's border radius
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: _lightScaffold,
      elevation: 0.5,
      titleTextStyle: TextStyle(
        color: _lightOnSurface,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black)),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CustomPageTransitionsBuilder(),
      TargetPlatform.macOS: CustomPageTransitionsBuilder(),
      TargetPlatform.windows: CustomPageTransitionsBuilder(),
    },
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 10,
    backgroundColor: _lightScaffold,
    selectedItemColor: _lightPrimary,
    unselectedItemColor: _lightSecondary,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
  ),
  cardColor: _lightCardColor,
  colorScheme: const ColorScheme.light(
    surface: _lightSurface,
    onSurface: _lightOnSurface,
    primary: _lightPrimary,
    onPrimary: _lightOnPrimary,
    secondary: _lightSecondary,
    onSecondary: _lightOnSecondary,
    tertiary: _lightTertiaryColor,
    onTertiary: _lightOnTertiaryColor,
    tertiaryContainer: _lightTertiaryContainerColor,
  ),
);
