import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../config/ui_settings.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  const GlassMorphism({
    super.key,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: borderRadius ?? outerBorderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3,
              ),
              child: ColoredBox(
                color: Colors.white.withOpacity(0.1),

                // alignment: Alignment.center,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
