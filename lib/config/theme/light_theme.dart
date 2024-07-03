import 'package:flutter/material.dart';

import 'page_transition.dart';

const appColor = Color(0xFF01579B);

final lightTheme = ThemeData.light(
        // useMaterial3: true,
        )
    .copyWith(
  primaryColor: const Color(0xFF01579B),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xFF01579B,
      {
        50: appColor,
        100: appColor,
        200: appColor,
        300: appColor,
        400: appColor,
        500: appColor,
        600: appColor,
        700: appColor,
        800: appColor,
        900: appColor,
      },
    ),
  ),
  // appBarTheme: const AppBarTheme(
  //     // elevation: 0,
  //     // backgroundColor: Colors.white,
  //     // surfaceTintColor: Colors.transparent,
  //     ),
  primaryColorLight: const Color(0xFF01579B),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
