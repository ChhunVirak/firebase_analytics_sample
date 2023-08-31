import 'package:flutter/material.dart';

class NoTransitionPageRoute extends PageRouteBuilder {
  final Widget page;

  NoTransitionPageRoute({
    required this.page,
  }) : super(
          settings: RouteSettings(name: page.runtimeType.toString()),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          // transitionsBuilder: (
          //   BuildContext context,
          //   Animation<double> animation,
          //   Animation<double> secondaryAnimation,
          //   Widget child,
          // ) =>
          //     child,
        );
}
