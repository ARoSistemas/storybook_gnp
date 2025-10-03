import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/services/network/network_service.dart';

final class ExceptionManager {
  static void handleError(Exception e) {
    if (e is HttpException) {
      showAlert(
        title: 'Http exception',
        message: e.message,
      );
    } else if (e is ApiException) {
      showAlert(
        title: 'Api exception',
        message: e.message,
      );
    } else {
      showAlert(
        title: 'Error',
        message: 'Ocurrió un error inesperado',
      );
    }
  }

  static void showAlert({
    required String title,
    required String message,
  }) => unawaited(
    Get.bottomSheet(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Aceptar'),
          ),
        ],
      ),
    ),
  );
}
