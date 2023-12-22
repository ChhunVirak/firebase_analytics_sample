import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';

final class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();

  ///Singleton
  factory AnalyticsService() => _instance;

  AnalyticsService._internal();

  static final _analytics = FirebaseAnalytics.instance;

  ///Set current user id
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
    _analytics.logScreenView();
  }

  ///Set extra property to current user
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(
      name: name,
      value: value,
    );
  }

  Future<void> removeCurrentUser() async {
    await _analytics.setUserId(id: null); //set null to remove userId
  }

  /// Logs the standard `screen_view` event.
  ///
  /// This event signifies a screen view. Use this when a screen transition occurs.
  Future<void> logScreenView({
    String? screenClass,
    required String screenName,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
    // _analytics.setCurrentScreen(screenName: screenName,callOptions: AnalyticsCallOptions(global: global));
  }

  ///
  Future<void> setCurrentScreen() async {
    await _analytics.setCurrentScreen(screenName: '');
  }

  /// Logs the standard `screen_view` event with custom parameters
  ///
  /// This event signifies a screen view. Use this when a screen transition occurs.
  Future<void> logScreenViewWithParam({
    required String screenName,
    Map<String, Object?>? parameters,
  }) async {
    final param = <String, Object?>{
      // 'screen_name': screenName,
      // 'screen_calss': 'Flutter',
      'screen_type': 'bic_payment',
    };

    await _analytics.logEvent(
      name: 'screen_view',
      parameters: param,
    );
  }

  Future<void> logCustomEvent({
    required String evetName,
    Map<String, dynamic>? parameters,
  }) async {
    assert(evetName != 'screen_view');

    await _analytics.logEvent(
      name: evetName,
      parameters: parameters,
    );
  }

  FirebaseAnalyticsObserver get firebaseAnalyticsObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}

class DebugObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('PUSH : $previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint('Replace : ${newRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('POP : ${previousRoute?.settings.name}');
  }
}
