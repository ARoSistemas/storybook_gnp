import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/extensions/responsive_extension.dart';
import 'package:storybook_gnp/shared/utils/colors/color_palette.dart';
import 'package:storybook_gnp/shared/widgets/avatar_user.dart';

class BannerUser extends StatelessWidget {
  const BannerUser({
    required this.name,
    required this.subTitle,
    required this.onTap,
    this.urlPhoto,
    super.key,
  });
  final String name;
  final String subTitle;
  final String? urlPhoto;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.white),
        borderRadius: BorderRadius.circular(5),
        color: ColorPalette.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(31, 0, 0, 0),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarUser(
                  name: name,
                  urlPhoto: urlPhoto,
                  isPerfil: false,
                  radius: 40,
                  onTap: onTap,
                ),
                SizedBox(width: context.scale(16)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Get.textTheme.titleMedium),
                    SizedBox(height: context.scale(3, axis: ScaleAxis.height)),
                    Text(
                      subTitle,
                      style: Get.textTheme.labelMedium?.copyWith(
                        color: ColorPalette.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorPalette.primary,
              size: 30,
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('urlPhoto', urlPhoto))
      ..add(StringProperty('name', name))
      ..add(StringProperty('subTitle', subTitle))
      ..add(ObjectFlagProperty<void Function()?>.has('onTap', onTap));
  }
}
