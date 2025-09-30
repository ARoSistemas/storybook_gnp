import 'package:flutter/material.dart';
import 'package:storybook_gnp/core/extensions/responsive_extension.dart';

class LogoGnp extends StatelessWidget {
  const LogoGnp({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: context.scale(115),
        child: Image.asset(
          'assets/logo-gnp.png',
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
