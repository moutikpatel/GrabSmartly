import 'package:flutter/material.dart';

import '../../../strings/string_size.dart';

class TOutlineButtonTheme {
  TOutlineButtonTheme._();

  //Light Theme
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.black,
      side: BorderSide(color: Colors.black87),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

  //Dark Theme
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.white70),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

}