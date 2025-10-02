part of '../intro_page.dart';

class _IntroDesktopPage extends StatelessWidget {
  _IntroDesktopPage();

  final IntroController _c = Get.find<IntroController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: Text(_c.state!.name),
    ),
    body: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Get.toNamed('/snackbar_overlay');
            },
            child: Text(
              'SnackBar Overlay',
              style: Get.textTheme.headlineMedium,
            ),
          ),

          /// New Button for File Operations Screen
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await Get.toNamed('/file-operations');
            },
            child: Text(
              'File Operations',
              style: Get.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    ),
  );
}
