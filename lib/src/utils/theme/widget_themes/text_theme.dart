import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    //SubTitleText
    displayMedium: GoogleFonts.archivo(color: Colors.black87,fontSize: 24, fontWeight: FontWeight.w600),
    displaySmall: GoogleFonts.archivo(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
    displayLarge: GoogleFonts.archivo(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),
    //BodyText
    bodyLarge: GoogleFonts.archivo(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.archivo(color: Colors.black87,fontSize: 24, fontWeight: FontWeight.w600),
    bodySmall: GoogleFonts.archivo(color: Colors.black87,fontSize: 18, fontWeight: FontWeight.w600),
    //Headline
    headlineLarge: GoogleFonts.archivo(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.archivo(color: Colors.black87,fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: GoogleFonts.archivo(color: Colors.black87,fontSize: 18, fontWeight: FontWeight.w700),
    //Title
    titleLarge: GoogleFonts.archivo(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),

  );

  static TextTheme darkTextTheme = TextTheme(
    //SubTitleText
    displayMedium: GoogleFonts.archivo(color: Colors.white,fontSize: 24, fontWeight: FontWeight.w600),
    displaySmall: GoogleFonts.archivo(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    displayLarge: GoogleFonts.archivo(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
    //BodyText
    bodyLarge: GoogleFonts.archivo(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.archivo(color: Colors.white,fontSize: 24, fontWeight: FontWeight.w600),
    bodySmall: GoogleFonts.archivo(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600),
    //Headline
    headlineLarge: GoogleFonts.archivo(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.archivo(color: Colors.white,fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: GoogleFonts.archivo(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w700),
    //Title
    titleLarge: GoogleFonts.archivo(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
  );
}