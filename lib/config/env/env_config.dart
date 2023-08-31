import 'dart:core';

class EnvConfig {
  const EnvConfig();
  final String _baseUrl = const String.fromEnvironment('base_url');
  String get baseUrl => _baseUrl;
}
