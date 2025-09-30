part of 'intro_page.dart';

class _IntroBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroController>(
      IntroController.new,
    );
  }
}
