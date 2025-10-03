import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:storybook_gnp/core/services/app_service.dart';
import 'package:storybook_gnp/core/services/network/network_service.dart';
import 'package:storybook_gnp/core/utils/logger.dart';
import 'package:storybook_gnp/shared/models/outgoing/login_response_model.dart';
import 'package:storybook_gnp/shared/services/storage/user_storage.dart';
import 'package:storybook_gnp/src/modules/login/services/auth_services.dart';

part 'intro_model.dart';

class IntroController extends GetxController with StateMixin<_IntroModel> {
  final AuthServices _authService = Get.put(AuthServices());
  final LocalAuthentication auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;
  RxBool canCheckBiometrics = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isEmailEntered = false.obs;
  final TextEditingController emailController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginController(String email, String password) async {
    final UserStorage userStorage = AppService.i.userStorage;
    try {
      isLoading.value = true;
      final LoginMdl response = await _authService.loginService(
        email,
        password,
      );
      userStorage.saveUser(response);
      if (response.token.jwt != '') {
        await Get.toNamed('/home');
      }
    } on ApiException catch (e) {
      logger.d(e);
    }
  }

  void toggleInputFields() {
    isEmailEntered.value = !isEmailEntered.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    const _IntroModel loginModel = _IntroModel();
    change(loginModel, status: RxStatus.success());
    await checkBiometricsSupport();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> checkBiometricsSupport() async {
    try {
      canCheckBiometrics.value = await auth.canCheckBiometrics;

      if (canCheckBiometrics.value) {
        availableBiometrics.assignAll(await auth.getAvailableBiometrics());
      }
    } on PlatformException catch (e) {
      logger.i('Error biometrics $e');
    }
  }

  Future<void> authenticate() async {
    if (!canCheckBiometrics.value) {
      Get.snackbar(
        'Error',
        'La biometría no está disponible en este dispositivo.',
      );
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor, autentíquese para acceder a la aplicación',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      isAuthenticated.value = didAuthenticate;

      if (didAuthenticate) {
        Get.snackbar(
          'Éxito',
          'Autenticación Biométrica Exitosa.',
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Fallo',
          'Autenticación Biométrica Fallida.',
          duration: const Duration(seconds: 2),
        );
      }
    } on PlatformException catch (e) {
      logger.i('Error durante la autenticación: $e');
      Get.snackbar('Error', 'Ocurrió un error al intentar autenticar.');
    }
  }

  void logout() {
    isAuthenticated.value = false;
    Get.snackbar('Sesión cerrada', 'Ha cerrado la sesión.');
  }
}
