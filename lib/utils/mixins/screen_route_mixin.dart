import 'package:flutter/material.dart';

mixin RouteMixin on StatefulWidget {
  abstract final String routeName;
}

class MyWidget extends StatefulWidget with RouteMixin {
  MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();

  @override
  String get routeName => throw UnimplementedError();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
