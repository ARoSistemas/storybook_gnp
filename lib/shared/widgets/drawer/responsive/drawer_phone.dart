import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/extensions/font_size_extension.dart';
import 'package:storybook_gnp/core/extensions/responsive_extension.dart';
import 'package:storybook_gnp/shared/utils/colors/color_palette.dart';
import 'package:storybook_gnp/shared/widgets/drawer/widgets/item_drawer.dart';

class DrawerPhone extends StatelessWidget {
  const DrawerPhone({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [
        ItemDrawer(
          icon: Icons.home_outlined,
          title: 'Inicio',
          onTap: () => Get.toNamed('/welcome'),
        ),
        ItemDrawer(
          icon: Icons.account_balance_outlined,
          title: 'Convenio Médico',
          onTap: () => Get.toNamed('/convenio-medico'),
        ),
        ItemDrawer(
          icon: Icons.account_balance_outlined,
          title: 'Tabuladores',
          onTap: () => Get.toNamed('/tabuladores'),
        ),
        ItemDrawer(
          icon: Icons.security_outlined,
          title: 'Mis pagos',
          onTap: () {},
        ),
        ItemDrawer(
          icon: Icons.shuffle_outlined,
          title: 'Solicitar convenio',
          onTap: () => Get.toNamed('/nueva-solicitud'),
        ),
        ItemDrawer(
          icon: Icons.description_outlined,
          title: 'Mis tramites',
          onTap: () {},
        ),
        ItemDrawer(
          icon: Icons.verified_outlined,
          title: 'Beneficios',
          onTap: () => Get.toNamed('/beneficios'),
        ),
        ItemDrawer(
          icon: Icons.attach_file_outlined,
          title: 'Anexos',
          onTap: () => Get.toNamed('/anexos'),
        ),
        ItemDrawer(
          icon: Icons.file_open_outlined,
          title: 'Formatos',
          onTap: () => Get.toNamed('/directorio'),
        ),
        ItemDrawer(
          icon: Icons.bar_chart,
          title: 'Formatos',
          onTap: () => Get.toNamed('/directorio'),
        ),
        ItemDrawer(
          icon: Icons.contact_phone_outlined,
          title: 'Directorio médico',
          onTap: () => Get.toNamed('/directorio'),
        ),
        ItemDrawer(
          icon: Icons.phone,
          title: 'Contacto GNP',
          onTap: () => Get.toNamed('/directorio'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.24),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Última sesión: 04/01/2025 12_18:11',
                style: TextStyle(
                  fontSize: context.fontSize(12),
                  color: ColorPalette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.scale(5, axis: ScaleAxis.height)),
              Text(
                'Versión 7.8.55',
                style: TextStyle(
                  fontSize: context.fontSize(12),
                  color: ColorPalette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
