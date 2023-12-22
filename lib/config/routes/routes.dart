import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../modules/payment/bloc/payment_bloc.dart';
import '../../modules/register/screens/register_screen.dart';
import '../../modules/transfer/bloc/transfer_bloc.dart';

import '../../modules/card/screens/card_screen.dart';
import '../../modules/dashboard/screens/dasboad_screen.dart';
import '../../modules/payment/screens/payment_listing_screen.dart';
import '../../modules/transfer/screens/transfer_screen.dart';
import '../../modules/user/screens/user_screen.dart';
import '../../modules/splashscreen/screens/splash_screen.dart';
import '../../utils/ui/animations/router/push_animation_pageroute.dart';

class AppRoute {
  static final routes = <String, WidgetBuilder>{
    '/sso': (_) => const SplashScreen(),
    '/setpin': (_) => const SetPin(),
    '/register': (_) => const RegisterScreen(),
    '/home': (_) => const DashBoard(),
    '/user': (_) => const UserScreen(),
    '/card': (_) => const CardScreen(),
    '/transfer': (_) => BlocProvider(
          create: (_) => TransferBloc(),
          child: const TransferScreen(),
        ),
    '/payment': (_) => BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(),
          child: const PaymentListingScreen(),
        ),
    // '/make-payment': (_) => BlocProvider<PaymentBloc>(
    //       create: (context) => context.read<PaymentBloc>(),
    //       child: const MakePaymentScreen(),
    //     ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final route = routes[routeName];
    debugPrint('OnGenerateRoute $routeName');
    final routeSettings = RouteSettings(name: routeName);
    if (route == null) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: null),
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not Found'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      AppPageRoute(
                        page: const DashBoard(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Home'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (routeName == '/home') {
      return PageRouteBuilder(
        settings: routeSettings,
        pageBuilder: (_, animation, secondaryAnimation) =>
            Builder(builder: route),
      );
    }
    return MaterialPageRoute(
      settings: routeSettings,
      builder: route,
    );
  }
}
