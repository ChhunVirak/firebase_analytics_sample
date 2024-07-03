import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/dark_theme.dart';
import 'config/theme/light_theme.dart';
import 'config/theme/theme_config.dart';
import 'constant/strings.dart';
import 'firebase_options.dart';
import 'modules/card/screens/card_screen.dart';
import 'modules/dashboard/screens/dasboad_screen.dart';

import 'utils/helpers/global_navigator.dart';
import 'utils/services/local_storage_service.dart';
import 'utils/services/pincode/bloc/pin_code_bloc.dart';
import 'utils/ui/dialogs/pincode_dialog.dart';

const String androidWidgetName = 'AppInfoWidget';
const String appGroupId = '<YOUR APP GROUP>';

const padding = 16.0;
const Duration animateDuration = Duration(milliseconds: 200);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseCrashlytics.instance
  //     .setCrashlyticsCollectionEnabled(!kDebugMode);
  await FirebaseCrashlytics.instance.setUserIdentifier('02');

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  ///Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await LocalSorageService().initPrefs();
  // await NetworkAssetManager().init();

  runApp(
    const MyApp(),
  );
}

// void updateHeadline(NewsArticle newHeadline) {
//   // Save the headline data to the widget
//   HomeWidget.saveWidgetData<String>('qrcode', newHeadline.path);

//   HomeWidget.updateWidget(
//     androidName: androidWidgetName,
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _appLinks.uriLinkStream.listen((uri) {
      _hanleDeeplink(uri);
    });
  }

  void _hanleDeeplink(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return;
    }
    final path = uri.pathSegments.first;
    final id = uri.pathSegments.lastOrNull;
    final query = uri.queryParameters;
    switch (path) {
      case 'payment':
        ContextUtility.navigatorKey.currentState?.pushNamed('/payment');

        break;

      case 'transfer':
        ContextUtility.navigatorKey.currentState?.pushNamed('/transfer');

        break;

      case 'card':
        ContextUtility.navigatorKey.currentState?.pushNamed('/card');

        break;

      case 'user':
        ContextUtility.navigatorKey.currentState?.pushNamed('/user');

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final plateformIsLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwitchThemeCubit(
            plateformIsLightMode ? ThemeMode.light : ThemeMode.dark,
          ),
        ),
        BlocProvider(
          create: (context) => PinCodeBloc()..service.init(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PinCodeBloc, PinCodeState>(
            listener: (context, state) {
              if (state is ShowPinState) {
                showPinCode(context);
              }
            },
          ),
        ],
        child: Builder(
          builder: (blocContext) {
            return MaterialApp(
              navigatorKey: ContextUtility.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              // navigatorObservers: const [
              //   // AnalyticsService().firebaseAnalyticsObserver,
              //   // DebugObserver(),
              // ],
              routes: AppRoute.routes,
              onGenerateRoute: AppRoute.onGenerateRoute,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
              home: const DashBoard(),
            );
          },
        ),
      ),
    );
  }
}

class AdvancedGoRouterAPp extends StatelessWidget {
  const AdvancedGoRouterAPp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return MaterialApp(
      // navigatorKey: ContextUtility.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: Strings.appName,

      // routerConfig: advRouter,
      // onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData.light(
          // colorScheme: ColorScheme.fromSwatch(
          //     // primarySwatch: Colors.pink,
          //     ),
          ),
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const DashBoard(),
    );
  }
}
