// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //----- Apply all theme data in this file ----- //

  static ThemeData APP_THEME = ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(),
        titleMedium: GoogleFonts.poppins(),
        titleSmall: GoogleFonts.poppins(),
        labelLarge: GoogleFonts.poppins(),
        labelMedium: GoogleFonts.poppins(),
        labelSmall: GoogleFonts.poppins(),
        bodyLarge: GoogleFonts.poppins(),
        bodyMedium: GoogleFonts.poppins(),
        bodySmall: GoogleFonts.poppins(),
      ));
}
