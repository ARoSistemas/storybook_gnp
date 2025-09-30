import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'custom_notification.dart';
import 'notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NotificationService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final notificationService = Get.find<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Ejemplo 1: Éxito con autocierre
                notificationService.showNotification(
                  title: "Éxito",
                  message: "La operación fue completada",
                  type: AlertType.success,
                );
              },
              child: Text('Éxito'),
            ),
            Divider(),

            ElevatedButton(
              onPressed: () {
                // Ejemplo 2: Error con botón de cerrar
                notificationService.showNotification(
                  title: "Error",
                  message: "Ocurrió un problema",
                  type: AlertType.error,
                  showCloseButton: true,
                );
              },
              child: Text('Error'),
            ),
            Divider(),

            ElevatedButton(
              onPressed: () {
                // Ejemplo 3: Info con acción
                notificationService.showNotification(
                  message: "Versión nueva disponible",
                  type: AlertType.info,
                  onAction: () {
                    print("Acción ejecutada");
                  },
                  actionLabel: "Actualizar",
                );
              },
              child: Text('Actualizar'),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
