import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get notchHeight => MediaQuery.of(this).size.height;

  double get notchWidth => MediaQuery.of(this).size.width;
}
