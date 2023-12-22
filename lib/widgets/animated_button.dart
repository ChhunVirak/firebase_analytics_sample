import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'
    show NumDurationExtensions;

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  @override
  void initState() {
    _animation = AnimationController(vsync: this, duration: 80.ms)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showLoading = true;
        } else {
          showLoading = false;
        }
      });
    super.initState();
  }

  bool showLoading = false;

  startLoading() {
    if (showLoading) {
      _animation.reverse();
    } else {
      _animation.forward();
    }
    // showLoading = !showLoading;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        startLoading();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  // duration: 50.ms,
                  padding: EdgeInsets.only(left: 20 * _animation.value),
                  child: showLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
