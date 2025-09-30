import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storybook_gnp/shared/utils/colors/color_palette.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: Icon(
      icon,
      color: ColorPalette.textTertiary,
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IconDataProperty('icon', icon))
      ..add(StringProperty('title', title))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap));
  }
}
