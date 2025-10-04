import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/src/modules/intro/intro_controller.dart';

part 'intro_bindins.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  static final GetPage page = GetPage(
    name: '/intro',
    page: IntroPage.new,
    transition: Transition.rightToLeft,
    binding: _IntroBindings(),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.lightBlue,
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
