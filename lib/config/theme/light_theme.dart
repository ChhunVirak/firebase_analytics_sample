// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'page_transition.dart';

final lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  primaryColor: Colors.indigo,
  colorScheme: const ColorScheme.light(
    primary: Colors.indigo,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColorLight: Colors.indigo,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

class Me {
  final String name;
  final int birthYear;
  final String position;

  Me({
    required this.name,
    required this.birthYear,
    required this.position,
  });

  @override
  String toString() {
    return 'Me{name=$name, birthYear=$birthYear, position=$position}';
  }
}
