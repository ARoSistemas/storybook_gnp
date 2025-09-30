import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/config/flavor_config.dart';
import 'package:storybook_gnp/core/messages/messages.dart';
import 'package:storybook_gnp/core/services/app_service.dart';
import 'package:storybook_gnp/core/services/ui/theme/app_theme_service.dart';
import 'package:storybook_gnp/core/utils/logger.dart';
import 'package:storybook_gnp/shared/messages/es/es_messages.dart';
import 'package:storybook_gnp/shared/navigation/app_navigation.dart';
import 'package:storybook_gnp/src/modules/intro/intro_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppThemeService theme = appService.ui.appTheme;
    return GetMaterialApp(
      title: FlavorConfig.appName,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: esMessages.mx.locale,
      logWriterCallback: _logWriter,
      initialRoute: IntroPage.page.name,
      getPages: AppNavigation.pages,
    );
  }
}

void _logWriter(String t, {bool isError = false}) => logger.d(t);
