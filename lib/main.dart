import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'config/theme/dark_theme.dart';
import 'config/theme/light_theme.dart';
import 'config/theme/theme_config.dart';
import 'constant/strings.dart';
import 'firebase_options.dart';
import 'home_widget.dart';
import 'modules/dashboard/screens/dasboad_screen.dart';
import 'utils/helpers/global_navigator.dart';
import 'utils/services/local_storage_service.dart';
import 'utils/services/pincode/bloc/pin_code_bloc.dart';
import 'utils/ui/animations/router/push_animation_pageroute.dart';
import 'utils/ui/dialogs/pincode.dart';

import 'utils/services/firebae/firebase_analytics_service.dart';
import 'utils/ui/dialogs/pincode_dialog.dart';

const String androidWidgetName = 'AppInfoWidget';
const String appGroupId = '<YOUR APP GROUP>';

const padding = 20.0;
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

void updateHeadline(NewsArticle newHeadline) {
  // Save the headline data to the widget
  HomeWidget.saveWidgetData<String>('qrcode', newHeadline.path);

  HomeWidget.updateWidget(
    androidName: androidWidgetName,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final plateformIsLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwitchThemeCubit(
            initialTheme: plateformIsLightMode ? lightTheme : darkTheme,
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
              navigatorObservers: [
                AnalyticsService().firebaseAnalyticsObserver,
                DebugObserver(),
              ],

              // routes: AppRoute.routes,
              // onGenerateRoute: AppRoute.onGenerateRoute,
              theme: blocContext.watch<SwitchThemeCubit>().state,
              home: const DashBoard(),
            );
          },
        ),
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
                    AppPageRoute(
                      page: const DashBoard(),
                    ),
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

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColoredBox(
          color: Colors.grey,
          child: OtpAutoRead(
            controller: _controller,
            onCompleted: (String pin) {},
            onFinishedTimer: () {},
            timer: 60,
          ),
        ),
      ),
    );
  }
}

class OtpAutoRead extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String pin) onCompleted;
  final void Function() onFinishedTimer;
  final int timer;

  const OtpAutoRead({
    super.key,
    required this.controller,
    required this.onCompleted,
    required this.onFinishedTimer,
    required this.timer,
  });

  @override
  State<OtpAutoRead> createState() => _OtpAutoReadState();
}

class _OtpAutoReadState extends State<OtpAutoRead>
    with SingleTickerProviderStateMixin {
  final focus = FocusNode();
  late TextEditingController controller = widget.controller;
  late AnimationController cursorController = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  );
  final Tween<double> cursor = Tween(begin: 0, end: 1);

  @override
  void initState() {
    cursorController.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focus.requestFocus();

      controller.addListener(() {
        if (controller.text.length == 6) {
          FocusScope.of(context).unfocus();
          widget.onCompleted(controller.text);
        }

        if (mounted) {
          setState(() {});
        }
      });

      focus.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    cursorController.dispose();
    focus.dispose();
    super.dispose();
  }

  // build cursor animate widget
  Widget _cursorAnimate() {
    return SizedBox(
      width: 2,
      child: AnimatedBuilder(
        animation: cursor.animate(cursorController),
        builder: (context, child) {
          return Visibility(
            visible: cursorController.value >= 0.5,
            child: Container(
              height: 20,
              width: 2,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(padding),
          child: InkWell(
            onTap: () {
              focus.requestFocus();
              // controller.selection = const TextSelection.collapsed(offset: 6);
            },
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            child: Column(
              children: [
                // background form
                Container(
                  color: Colors.transparent,
                  child: FocusScope(
                    canRequestFocus: true,
                    // width: 100,
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: controller,
                      focusNode: focus,
                      keyboardType: TextInputType.number,
                      // cursorColor: Colors.transparent,
                      // cursorWidth: 0,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],

                      style: const TextStyle(
                        fontSize: 50,
                        // color: Colors.transparent,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'hidden pin form',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // display form
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      6,
                      (index) {
                        final bool filled = index < controller.text.length;
                        final int curserIndex = controller.text.length;

                        return AnimatedContainer(
                          duration: animateDuration,
                          height: 50,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: focus.hasFocus && curserIndex == index
                                ? Colors.green.withOpacity(.7)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(padding * .5),
                          ),
                          margin: const EdgeInsets.only(right: 8),
                          child: Builder(
                            builder: (context) {
                              if (curserIndex == index && focus.hasFocus) {
                                return _cursorAnimate();
                              }

                              if (focus.hasFocus &&
                                  controller.text.length == 6 &&
                                  index == 6 - 1) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 3),
                                    Text(
                                      filled ? controller.text[index] : '',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height <=
                                                812
                                            ? 16
                                            : 18,
                                      ),
                                    ),
                                    const SizedBox(width: 1),
                                    _cursorAnimate(),
                                  ],
                                );
                              }

                              return Text(
                                filled ? controller.text[index] : '',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize:
                                      MediaQuery.of(context).size.height <= 812
                                          ? 16
                                          : 18,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // timer widget
      ],
    );
  }
}
