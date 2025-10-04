import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/services/app_service.dart';
import 'package:storybook_gnp/core/utils/logger.dart';
import 'package:storybook_gnp/src/app.dart';

Future<void> main() async {
  final AppService app = Get.put(AppService());
  await app.init();
  logger.i('App Service started');

  runApp(const App());
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import 'package:storybook_gnp/custom_notification.dart';
// import 'package:storybook_gnp/notification_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(NotificationService());
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) => GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
//     ),
//     home: const MyHomePage(),
//   );
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final NotificationService notificationService =
//       Get.find<NotificationService>();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       title: const Text('StoryBook for Projects GNP - Flutter'),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               // Ejemplo 1: Éxito con autocierre
//               notificationService.showNotification(
//                 title: 'Éxito',
//                 message: 'La operación fue completada',
//                 type: AlertType.success,
//               );
//             },
//             child: const Text('Éxito'),
//           ),
//           const Divider(),

//           ElevatedButton(
//             onPressed: () {
//               // Ejemplo 2: Error con botón de cerrar
//               notificationService.showNotification(
//                 title: 'Error',
//                 message: 'Ocurrió un problema',
//                 type: AlertType.error,
//                 showCloseButton: true,
//               );
//             },
//             child: const Text('Error'),
//           ),
//           const Divider(),

//           ElevatedButton(
//             onPressed: () {
//               // Ejemplo 3: Info con acción
//               notificationService.showNotification(
//                 message: 'Versión nueva disponible',
//                 type: AlertType.info,
//                 onAction: () {
//                   // print('Acción ejecutada');
//                 },
//                 actionLabel: 'Actualizar',
//               );
//             },
//             child: const Text('Actualizar'),
//           ),
//           const Divider(),
//         ],
//       ),
//     ),
//   );

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//       DiagnosticsProperty<NotificationService>(
//         'notificationService',
//         notificationService,
//       ),
//     );
//   }
// }
