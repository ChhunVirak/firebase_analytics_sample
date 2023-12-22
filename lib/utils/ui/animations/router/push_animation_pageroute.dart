import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/stateless_screen_route_widget.dart';

class AppPageRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;
  final String route;

  static String getRouteName(Widget page) {
    ///for `BlocProvide` will take child class in provider as screen name
    if (page is BlocProvider) {
      return page.child.runtimeType.toString();
    }

    if (page is StateLessScreenRoute) {
      return page.routeName;
    }

    ///Normal Widget it will take class name as screen name
    return page.runtimeType.toString();
  }

  AppPageRoute({
    required this.page,
    this.routeSettings,
    this.route = '',
  }) : super(
          settings: RouteSettings(
            name: route,
          ),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.bounceInOut,
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: page,
            ),
          ),
        );
}
