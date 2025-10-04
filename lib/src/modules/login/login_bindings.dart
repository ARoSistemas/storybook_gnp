part of 'login_page.dart';

class _LoginBindings extends Bindings {
  @override
  void dependencies() {
    final ApiCallAbstract apiCall = ApiCallImpl();

    Get.lazyPut<LoginController>(
      () => LoginController(apiCall),
    );
  }
}
