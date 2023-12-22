import 'dart:async';

class Debouncer {
  Timer? _debounce;

  final Duration duration = const Duration(seconds: 1);

  void bounce(void Function() callBack) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(duration, callBack);
  }
}
