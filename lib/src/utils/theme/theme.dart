import 'package:flutter/material.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';
import 'package:grabsmartly/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:grabsmartly/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:grabsmartly/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: tAppBarColor
    ),
    scaffoldBackgroundColor: tScaffoldColor,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlineButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        color: tDarkAppBarColor
    ),
    scaffoldBackgroundColor: tDarkScaffoldColor,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,


  );
}