import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/config/theme/dark_theme.dart';
import 'package:learn_bloc/config/theme/light_theme.dart';
import 'package:learn_bloc/config/theme/theme_config.dart';
import 'package:learn_bloc/firebase_options.dart';
import 'package:learn_bloc/constant/strings.dart';
import 'package:learn_bloc/modules/dashboard/screens/dasboad_screen.dart';
import 'package:learn_bloc/modules/splashscreen/screens/splash_screen.dart';
import 'package:learn_bloc/utils/services/asset_manager/network_asset_manager.dart';

import 'package:learn_bloc/utils/services/firebae/firebase_analytics_service.dart';
import 'package:learn_bloc/utils/services/local_storage_service.dart';
import 'package:learn_bloc/utils/ui/animations/router/push_animation_pageroute.dart';
import 'package:learn_bloc/utils/ui/dialogs/pincode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  ///Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  await LocalSorageService().initPrefs();
  await NetworkAssetManager().init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final plateformIsLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return BlocProvider(
      create: (_) => SwitchThemeCubit(
        initialTheme: !plateformIsLightMode ? lightTheme : darkTheme,
      ),
      child: Builder(
        builder: (blocContext) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            navigatorObservers: [
              AnalyticsService().firebaseAnalyticsObserver,
            ],

            // routes: AppRoute.routes,
            // onGenerateRoute: AppRoute.onGenerateRoute,
            theme: blocContext.watch<SwitchThemeCubit>().state,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SetPin extends StatelessWidget {
  const SetPin({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SetPinCodeScreen(
        pin: null,
        onCompleted: (v) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SetPinCodeScreen(
                pin: v,
                onCompleted: (value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    AppPageRoute(page: const DashBoard()),
                    (route) => false,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
