import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/extensions/null_extensions.dart';
import 'package:storybook_gnp/core/extensions/responsive_extension.dart';
import 'package:storybook_gnp/shared/utils/colors/color_palette.dart';
import 'package:storybook_gnp/shared/widgets/avatar_user.dart';

class BannerMedico extends StatelessWidget {
  const BannerMedico({
    required this.name,
    required this.medicalIdentifier,
    required this.photo,
    super.key,
  });

  final String name;
  final String medicalIdentifier;
  final String photo;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: const BoxDecoration(color: ColorPalette.backgroundCardBanner),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: context.scale(16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre:', style: Get.textTheme.bodySmall),
                SizedBox(height: context.scale(4, axis: ScaleAxis.height)),
                Text('No Doc:', style: Get.textTheme.bodySmall),
              ],
            ),
            SizedBox(width: context.scale(25)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.value(),
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: ColorPalette.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.scale(4, axis: ScaleAxis.height)),
                Text(
                  medicalIdentifier.value(),
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: ColorPalette.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarUser(
              name: name,
              urlPhoto: 'assets/user-img-2.png',
              isPerfil: false,
              radius: 20,
              onTap: () {},
            ),
            SizedBox(width: context.scale(16)),
          ],
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(StringProperty('photo', photo));
  }
}
