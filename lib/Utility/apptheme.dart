import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData getTheme(bool isdark){
    return ThemeData(
      useMaterial3: true,
      colorScheme: isdark ? ColorScheme.dark():ColorScheme.light(),
    );
  }
}