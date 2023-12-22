import 'dart:developer' as devtools show log;

extension Log on Object {
  void log([String? name]) => devtools.log(toString(), name: name ?? '');
}
