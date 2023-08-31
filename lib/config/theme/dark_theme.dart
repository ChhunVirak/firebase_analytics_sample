import 'package:flutter/material.dart';
import 'package:learn_bloc/config/theme/page_transition.dart';

ThemeData darkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  primaryColor: Colors.indigo,
  colorScheme: const ColorScheme.dark(
    primary: Colors.indigo,
  ),
  // cardColor: const Color(0xff101111),
  primaryColorLight: Colors.indigo,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
