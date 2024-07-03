import 'package:flutter/material.dart';

class DynamicDarkMode extends StatelessWidget {
  const DynamicDarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: Center(
        child: Text(
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? 'DARK'
              : 'LIGHT',
        ),
      ),
    );
  }
}
