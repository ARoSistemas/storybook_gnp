import 'package:flutter/widgets.dart';

enum ScaleAxis {
  width,
  height,
}

extension ResponsiveSizeExtension on BuildContext {
  static const int _designReference = 375;
  static const double _lowerLimit = 0.9;
  static const double _upperLimit = 1.2;

  double scale(double px, {ScaleAxis axis = ScaleAxis.width}) {
    final Size size = MediaQuery.of(this).size;
    final double dimension = axis == ScaleAxis.width ? size.width : size.height;
    return (dimension / _designReference).clamp(_lowerLimit, _upperLimit) * px;
  }
}
