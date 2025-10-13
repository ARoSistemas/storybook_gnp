import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIconSVG extends StatelessWidget {
  /// **Parameters**:
  /// - `height` (double?, optional):
  ///    The height of the icon. Default is `25`.
  ///
  /// - `width` (double?, optional):
  ///    The width of the icon. Default is `25`.
  ///
  /// - `bgColor` (Color?, optional):
  ///    The background color of the icon. Default is the `onPrimary` color from the theme.
  ///
  /// - `icon` (String):
  ///    The name or path of the icon to be displayed.
  ///
  /// **Notes**:
  /// - The `MyIconSVG` widget uses the `LibFunc.getIcon` and `LibFunc.getIconFromColor`
  ///   methods to fetch the appropriate icon based on the `isFromColor` parameter.
  ///
  /// - The `bgColor` parameter is used to apply a color filter to the icon.
  ///   If `bgColor` is not provided, the `onPrimary` color from the current theme is used.
  ///
  /// - The `copyWith` method allows for creating a copy of the `MyIconSVG` widget with
  ///   modified properties.
  ///
  /// **Example**:
  /// ```dart
  /// MyIconSVG(
  ///   h: 50,
  ///   w: 50,
  ///   bgColor: Colors.blue,
  ///   isFromColor: true,
  ///   icon: 'icon',
  /// )
  /// ```
  const MyIconSVG({
    required this.icon,
    super.key,
    this.height,
    this.width,
    this.bgColor,
  });

  final double? height;
  final double? width;
  final Color? bgColor;
  final String icon;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    ARoAssets.svg(icon),
    height: height ?? 25,
    width: width ?? 25,
    colorFilter: ColorFilter.mode(
      bgColor ?? Theme.of(context).colorScheme.onPrimary,
      BlendMode.srcIn,
    ),
  );

  MyIconSVG copyWith({
    double? height,
    double? width,
    Color? bgColor,
    String? icon,
  }) => MyIconSVG(
    height: height ?? this.height,
    width: width ?? this.width,
    bgColor: bgColor ?? this.bgColor,
    icon: this.icon,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
    properties.add(ColorProperty('bgColor', bgColor));
    properties.add(StringProperty('icon', icon));
  }
}
