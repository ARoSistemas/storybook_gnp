import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:storybook_gnp/core/config/constans.dart';
import 'package:storybook_gnp/core/services/app_service.dart';
import 'package:storybook_gnp/core/services/network/api_call.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';
import 'package:storybook_gnp/core/utils/logger.dart';
import 'package:storybook_gnp/shared/services/alerts/notification_service.dart';
import 'package:storybook_gnp/shared/services/storage/user_storage.dart';
import 'package:storybook_gnp/shared/widgets/custom_notification.dart';
import 'package:storybook_gnp/src/modules/login/login_model.dart';

// part 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {
  LoginController(this.apiCall);
  final ApiCallAbstract apiCall;

  final LocalAuthentication auth = LocalAuthentication();

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isAuthenticated = false.obs;
  RxBool canCheckBiometrics = false.obs;
  RxBool isLoading = false.obs;
  RxBool isEmailEntered = false.obs;
  RxBool isPasswordVisible = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  // Getter rápido para acceder al user en toda la app
  LoginModel get currentUser => state ?? LoginModel.empty();

  Future<void> login(String email, String password) async {
    final UserStorage userStorage = AppService.i.userStorage;
    final NotificationService notify = AppService.i.notifications;
    LoginModel user = LoginModel.empty();
    isLoading.value = true;

    if (isHardCode) {
      await Future.delayed(const Duration(milliseconds: 1750));
      user = LoginModel.hardCode();
      userStorage.saveUser(user);
      change(user, status: RxStatus.success());
      unawaited(Get.toNamed('/home'));
    } else {
      /// Se hace la petición a la API
      final ApiResponse<ApiFailure, ApiSuccess> response = await apiCall.call(
        baseUri: baseUrl,
        bearer: '',
        endpoint: '/admonproveedores/conveniomedico/login',
        method: HttpMethod.post,
        body: jsonEncode(
          {
            'mail': email,
            'password': password,
            'tipousuario': 'administrador',
          },
        ),
      );

      response.when(
        (failure) {
          notify.showNotification(
            title: 'Error',
            message: failure.message,
            type: AlertType.error,
            showCloseButton: true,
          );

          change(LoginModel.empty(), status: RxStatus.error(failure.message));
        },
        (success) {
          user = LoginModel.fromRaw(success.data);
          userStorage.saveUser(user);
          change(user, status: RxStatus.success());
          unawaited(Get.toNamed('/home'));
        },
      );
    }

    isLoading.value = false;
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
    change(LoginModel.empty(), status: RxStatus.success());
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
