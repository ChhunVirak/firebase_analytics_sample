import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../bloc/splashscreen_bloc.dart';
import '../../../utils/ui/animations/router/push_animation_pageroute.dart';

import '../../../utils/ui/animations/router/no_transition_pageroute_builder.dart';
import '../../dashboard/screens/dasboad_screen.dart';
import '../../register/screens/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashscreenBloc _registerBloc = SplashscreenBloc();
  @override
  void initState() {
    _registerBloc.add(CheckUserEvent());

    super.initState();
    // HomeWidget.setAppGroupId(appGroupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashscreenBloc, SplashscreenState>(
        bloc: _registerBloc,
        listener: (_, state) {
          debugPrint('State $state');

          if (state is NoUserState) {
            Navigator.of(context).pushAndRemoveUntil(
              AppPageRoute(page: const RegisterScreen()),
              (_) => false,
            );
          }
          if (state is HasUserState) {
            Navigator.of(context).pushAndRemoveUntil(
              NoTransitionPageRoute(page: const DashBoard()),
              (_) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BIC Mobile',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.indigo[900],
                ),
              ),
              const SizedBox(height: 20),
              Platform.isIOS
                  ? CupertinoActivityIndicator(
                      color: Colors.indigo[900],
                    )
                  : CircularProgressIndicator(
                      color: Colors.indigo[900],
                      // value: 1,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
