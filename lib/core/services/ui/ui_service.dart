import 'package:get/get.dart';
import 'package:storybook_gnp/core/services/ui/theme/app_theme_service.dart';

class UIService extends GetxService {
  late final AppThemeService appTheme;

  Future<void> init() async {
    appTheme = Get.put(AppThemeService());
    await appTheme.init();
  }
}
