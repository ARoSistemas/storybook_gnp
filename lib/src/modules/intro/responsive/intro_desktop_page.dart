part of '../intro_page.dart';

class _IntroDesktopPage extends StatelessWidget {
  const _IntroDesktopPage();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      title: const Text('HomePage StoryBook'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Get.toNamed('/login');
              },
              child: Text(
                'Login',
                style: Get.textTheme.headlineMedium,
              ),
            ),
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
    ),
  );
}
