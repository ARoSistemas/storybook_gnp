import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storybook_gnp/core/services/alerts/notification_service.dart';
import 'package:storybook_gnp/core/services/navigation/navigation_service.dart';
import 'package:storybook_gnp/core/services/network/network_service.dart';
import 'package:storybook_gnp/core/services/security/cipher_service.dart';
import 'package:storybook_gnp/core/services/threads/threads_service.dart';
import 'package:storybook_gnp/core/services/ui/ui_service.dart';
import 'package:storybook_gnp/shared/services/storage/user_storage.dart';

part 'storage/storage_service.dart';

final AppService appService = AppService.i;

class AppService extends GetxService {
  static final AppService i = Get.find<AppService>();

  late final CipherService cipher;
  late final NavigationService navigation;
  late final NetworkService network;
  late final StorageService storage;
  late final ThreadsService threads;
  late final UIService ui;
  late final UserStorage userStorage;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    cipher = Get.put(CipherService());
    navigation = Get.put(NavigationService());
    network = Get.put(NetworkService());
    storage = Get.put(StorageService());
    threads = Get.put(ThreadsService());
    ui = Get.put(UIService());

    ///
    Get.put(NotificationService());

    await storage.init();
    await ui.init();

    userStorage = UserStorage();
    await userStorage.init();
    await userStorage.loadAll();
  }
}
