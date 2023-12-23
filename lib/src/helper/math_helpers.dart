import 'dart:math';

class MathHelpers {
  double roundDouble(double value, int places) {
    num  mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
