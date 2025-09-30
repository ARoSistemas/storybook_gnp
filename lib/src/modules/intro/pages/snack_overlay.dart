import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:storybook_gnp/core/services/alerts/notification_service.dart';
import 'package:storybook_gnp/core/utils/logger.dart';
import 'package:storybook_gnp/shared/widgets/custom_notification.dart';

class SnackBarOverlay extends StatelessWidget {
  SnackBarOverlay({super.key});

  static final GetPage page = GetPage(
    name: '/snackbar_overlay',
    page: SnackBarOverlay.new,
    transition: Transition.rightToLeft,
  );

  final NotificationService notificationService =
      Get.find<NotificationService>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.lightBlue.shade300,
      title: const Text('SnackBar Overlay Test'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Message success
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Ejemplo 1: Éxito con autocierre
                notificationService.showNotification(
                  title: 'Éxito',
                  message: 'La operación fue completada',
                  type: AlertType.success,
                );
              },
              child: const Text('Éxito'),
            ),
          ),
          const Divider(),

          /// Message Warning
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Ejemplo 1: Éxito con autocierre
                notificationService.showNotification(
                  title: 'Éxito',
                  message: 'La operación fue completada con detalles',
                  type: AlertType.warning,
                );
              },
              child: const Text('Warning'),
            ),
          ),
          const Divider(),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Ejemplo 2: Error con botón de cerrar
                notificationService.showNotification(
                  title: 'Error',
                  message: 'Ocurrió un problema',
                  type: AlertType.error,
                  showCloseButton: true,
                );
              },
              child: const Text('Error'),
            ),
          ),
          const Divider(),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Ejemplo 3: Info con acción
                notificationService.showNotification(
                  message: 'Notificación con Callback y cierre autómatico',
                  type: AlertType.info,
                  onAction: () {
                    Logger();
                    logger.i('Acción ejecutada');
                  },
                  actionLabel: 'onTap',
                );
              },
              child: const Text('Callback'),
            ),
          ),
          const Divider(),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<NotificationService>(
        'notificationService',
        notificationService,
      ),
    );
  }
}
