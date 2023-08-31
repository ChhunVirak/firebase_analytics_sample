import 'package:firebase_analytics/firebase_analytics.dart';

final class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();

  ///Singleton
  factory AnalyticsService() => _instance;

  AnalyticsService._internal();

  static final _analytics = FirebaseAnalytics.instance;

  setData() {
    // _analytics.
  }

  ///Set current user id
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
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
    _analytics.logAddPaymentInfo();
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
    required String screenClass,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: 'screen_view',
      parameters: <String, dynamic>{
        'firebase_screen': screenName,
        'firebase_screen_class': screenClass,
        ...parameters ?? {},
      },
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
 