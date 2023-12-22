import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dark_theme.dart';
import 'light_theme.dart';
import '../../utils/services/firebae/firebase_analytics_service.dart';

class SwitchThemeCubit extends Cubit<ThemeData> {
  /// Constructor.
  SwitchThemeCubit({required this.initialTheme}) : super(initialTheme);

  /// Initial theme will provide by schedulerBinding.
  final ThemeData initialTheme;

  final AnalyticsService _analyticsService = AnalyticsService();

  void setUserTheme() async {
    await _analyticsService.setUserProperty(
      name: 'app_theme',
      value: state == lightTheme ? 'light_mode' : 'dark_mode',
    );
  }

  bool get isDarkMode => state == darkTheme;

  /// Switches the theme
  void switchTheme() {
    state == lightTheme ? emit(darkTheme) : emit(lightTheme);
    setUserTheme();
  }
}
