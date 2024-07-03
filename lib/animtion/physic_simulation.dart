import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PhysicSimulation extends StatefulWidget {
  const PhysicSimulation({super.key});

  @override
  State<PhysicSimulation> createState() => _PhysicSimulationState();
}

class _PhysicSimulationState extends State<PhysicSimulation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final SpringSimulation simulation = SpringSimulation(
    const SpringDescription(
      mass: 1.0,
      stiffness: 100.0,
      damping: 10.0,
    ),
    0.0, // start value
    360.0, // end value
    10,
    tolerance: const Tolerance(
      distance: 360,
      time: 2,
    ), // velocit
  );

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: 1.seconds,
    );

    // controller.forward();
    // controller.repeat();

    // controller.animateWith(simulation);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.value = 0;
          controller.animateWith(simulation);
        },
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: RadialPainter(DateTime.now()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  final DateTime _datetime;

  RadialPainter(this._datetime);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.width, size.height) / 2;

    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, size.width / 2, paint);
    canvas.drawCircle(
      const Offset(0, 0),
      radius,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );

    // Paint progressPaint = Paint()
    //   ..shader = const LinearGradient(
    //     colors: [
    //       Colors.orangeAccent,
    //       Colors.orange,
    //       Colors.deepOrange,
    //     ],
    //   ).createShader(
    //     Rect.fromCircle(center: Offset.zero, radius: size.width / 2),
    //   )
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 20.0;

    double L = 110;
    double S = 6;
    _paintHourHand(canvas, L / 2.0, S);
    _paintMinuteHand(canvas, L / 1.4, 3);
    _paintSecondHand(canvas, L / 1.2, 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /// drawing hour hand
  void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.hour % 12 + _datetime.minute / 60.0 - 3;
    Offset handOffset = Offset(
      math.cos(getRadians(angle * 30)) * radius,
      math.sin(getRadians(angle * 30)) * radius,
    );
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, hourHandPaint);

    Paint centerPointPaint = Paint()
      ..strokeWidth = ((radius - 10) / 10)
      ..strokeCap = StrokeCap.round
      ..color = Colors.black
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.points, [Offset.zero], centerPointPaint);
  }

  /// drawing minute hand
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.minute - 15.0;
    Offset handOffset = Offset(
      math.cos(getRadians(angle * 6.0)) * radius,
      math.sin(getRadians(angle * 6.0)) * radius,
    );
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 0), handOffset, hourHandPaint);
  }

  /// drawing second hand
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.second - 15.0;
    Offset handOffset = Offset(
      math.cos(getRadians(angle * 6.0)) * radius,
      math.sin(getRadians(angle * 6.0)) * radius,
    );
    final hourHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 0), handOffset, hourHandPaint);
  }

  static double getRadians(double angle) {
    return angle * math.pi / 180;
  }
}
