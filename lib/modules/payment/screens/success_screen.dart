import 'package:flutter/material.dart';

import '../../../utils/ui/animations/router/no_transition_pageroute_builder.dart';
import '../../dashboard/screens/dasboad_screen.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          NoTransitionPageRoute(
            page: const DashBoard(),
          ),
          (_) => false,
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'Successfull',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    NoTransitionPageRoute(
                      page: const DashBoard(),
                    ),
                    (_) => false,
                  );
                },
                child: const Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
