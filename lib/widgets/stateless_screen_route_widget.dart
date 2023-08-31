import 'package:flutter/material.dart';

abstract class StateLessScreenRoute extends StatelessWidget {
  const StateLessScreenRoute({super.key}) : super();

  String get routeName;

  @protected
  @override
  Widget build(BuildContext context);
}

class Screen extends StateLessScreenRoute {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  String get routeName => 'Screen';
}
