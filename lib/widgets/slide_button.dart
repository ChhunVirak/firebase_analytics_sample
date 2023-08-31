import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'
    show NumDurationExtensions;

class SlideButton extends StatefulWidget {
  const SlideButton({super.key});

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  double startPosition = 0;
  @override
  void initState() {
    _animation = AnimationController(vsync: this, duration: 200.ms);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final innerSize = MediaQuery.of(context).size.width - 110;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(2),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.indigo,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
      ),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        // (details) {
        //   debugPrint('Drage x ${details.globalPosition.dx}');
        // },
        onVerticalDragEnd: _onVerticalDragEnd,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return Container(
              margin: EdgeInsets.only(
                // left: 0,
                left: innerSize * _animation.value,
              ),
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                // color: Colors.indigo,

                border: Border.all(),
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.globalPosition.dx > 32 &&
        details.globalPosition.dx < MediaQuery.of(context).size.width - 32) {
      final currentWidth = details.globalPosition.dx - 32 - startPosition;
      _animation.value =
          currentWidth / (MediaQuery.of(context).size.width - 32);
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_animation.value < .5) {
      _animation.animateBack(0);
    } else {
      _animation.animateTo(1);
    }
    startPosition = 0;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    startPosition = details.localPosition.dx;
  }
}
