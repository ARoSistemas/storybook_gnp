import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/src/modules/intro/intro_controller.dart';
import 'package:storybook_gnp/src/modules/login/login_controller.dart';

part 'intro_bindins.dart';

part 'responsive/intro_desktop_page.dart';

// part 'responsive/intro_phone_page.dart';

// part 'responsive/intro_tablet_page.dart';

class IntroPage extends GetResponsiveView<LoginController> {
  IntroPage({super.key});

  static final GetPage page = GetPage(
    name: '/intro',
    page: IntroPage.new,
    transition: Transition.rightToLeft,
    binding: _IntroBindings(),
  );

  @override
  Widget? phone() => const _IntroDesktopPage();

  @override
  Widget? tablet() => const _IntroDesktopPage();

  @override
  Widget? desktop() => const _IntroDesktopPage();
}
