import 'package:flutter/material.dart';

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Customize your transition animations here
    // Example: use FadeTransition or SlideTransition
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.bounceInOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      ),
    );
  }
}
