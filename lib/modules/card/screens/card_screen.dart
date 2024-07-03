import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Screen'),
      ),
      body: Center(
        child: CustomPaint(
          painter: RectPanter(),
        ),
      ),
    );
  }
}

class RectPanter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.red;

    final Rect rect = MyRect();
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyRect implements Rect {
  @override
  double get bottom => throw UnimplementedError();

  @override
  Offset get bottomCenter => throw UnimplementedError();

  @override
  Offset get bottomLeft => throw UnimplementedError();

  @override
  Offset get bottomRight => throw UnimplementedError();

  @override
  Offset get center => throw UnimplementedError();

  @override
  Offset get centerLeft => throw UnimplementedError();

  @override
  Offset get centerRight => throw UnimplementedError();

  @override
  bool contains(Offset offset) {
    throw UnimplementedError();
  }

  @override
  Rect deflate(double delta) {
    throw UnimplementedError();
  }

  @override
  Rect expandToInclude(Rect other) {
    throw UnimplementedError();
  }

  @override
  bool get hasNaN => throw UnimplementedError();

  @override
  double get height => throw UnimplementedError();

  @override
  Rect inflate(double delta) {
    throw UnimplementedError();
  }

  @override
  Rect intersect(Rect other) {
    throw UnimplementedError();
  }

  @override
  bool get isEmpty => throw UnimplementedError();

  @override
  bool get isFinite => throw UnimplementedError();

  @override
  bool get isInfinite => throw UnimplementedError();

  @override
  double get left => throw UnimplementedError();

  @override
  double get longestSide => throw UnimplementedError();

  @override
  bool overlaps(Rect other) {
    throw UnimplementedError();
  }

  @override
  double get right => throw UnimplementedError();

  @override
  Rect shift(Offset offset) {
    throw UnimplementedError();
  }

  @override
  double get shortestSide => throw UnimplementedError();

  @override
  Size get size => throw UnimplementedError();

  @override
  double get top => throw UnimplementedError();

  @override
  Offset get topCenter => throw UnimplementedError();

  @override
  Offset get topLeft => throw UnimplementedError();

  @override
  Offset get topRight => throw UnimplementedError();

  @override
  Rect translate(double translateX, double translateY) {
    throw UnimplementedError();
  }

  @override
  double get width => 100;
}
