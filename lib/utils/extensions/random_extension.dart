import 'dart:math' as math show Random;

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
  T next(T current) {
    int index = toList().indexWhere((element) => element == current);
    if (index < length - 1) {
      return elementAt(index + 1);
    }
    return first;
  }

  T? operator [](int index) => length > index ? elementAt(index) : null;
}
