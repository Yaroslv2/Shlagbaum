import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.white10),
  bottomAppBarTheme: const BottomAppBarTheme(elevation: 0),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.black,
  ),
  snackBarTheme: const SnackBarThemeData(
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodySmall: GoogleFonts.openSans(
        color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.openSans(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
    headlineMedium: GoogleFonts.anonymousPro(
        color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    
  ),
);
