import 'package:flutter/material.dart';

import '../../../strings/string_size.dart';

class TElevatedButtonTheme{

  TElevatedButtonTheme._();

  //Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black87,
      side: BorderSide(color: Colors.black87),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

  //Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

}