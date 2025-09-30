part of 'login_page.dart';

class _LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        LoginController.new,
    );
  }
}
