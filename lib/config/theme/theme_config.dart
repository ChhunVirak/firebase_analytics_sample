import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../utils/services/firebae/firebase_analytics_service.dart';

class SwitchThemeCubit extends Cubit<ThemeMode> {
  /// Constructor.
  SwitchThemeCubit(super.initialState);

  /// Initial theme will provide by schedulerBinding.
  // final ThemeData _initialTheme;

  final AnalyticsService _analyticsService = AnalyticsService();

  void setUserTheme() async {
    await _analyticsService.setUserProperty(
      name: 'app_theme',
      value: state == ThemeMode.light ? 'light_mode' : 'dark_mode',
    );
  }

  bool get isDarkMode => state == ThemeMode.dark;

  /// Switches the theme
  void switchTheme() {
    state == ThemeMode.light ? emit(ThemeMode.dark) : emit(ThemeMode.light);
    setUserTheme();
  }
}
