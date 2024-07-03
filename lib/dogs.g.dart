import 'package:dogs_core/dogs_core.dart';

Future initialiseDogs() async {
  var engine = DogEngine.hasValidInstance ? DogEngine.instance : DogEngine();
  engine.registerAllConverters([]);
  engine.setSingleton();
}
