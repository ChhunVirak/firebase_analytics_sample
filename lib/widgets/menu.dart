import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learn_bloc/config/ui_settings.dart';
import 'package:learn_bloc/utils/extensions/theme_extension.dart';

class Menu extends StatefulWidget {
  final AnimationController animationController;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPressed;
  final String text;
  const Menu({
    super.key,
    this.onLongPressed,
    required this.text,
    required this.animationController,
    this.onTap,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPressed,

      // onTapUp: _onTapUp,
      // onTapCancel: onTapCancel,

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: context.cardColor,
                // gradient: context.read<SwitchThemeCubit>().isDarkMode
                //     ? LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Colors.indigo[600]!,
                //           Colors.indigo,
                //           Colors.indigo[600]!,
                //         ],
                //       )
                //     : null,
                // color: _colorTween.animate(_colorAnimationController).value,
                borderRadius: innerBorderRadius,
              ),
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.monetization_on_rounded,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      // color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.animationController.isAnimating)
            Positioned(
              left: -10,
              top: -10,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 15,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    )
        .animate(
          autoPlay: false,
          controller: widget.animationController,
        )
        .shake(rotation: 0.03);
  }
}
