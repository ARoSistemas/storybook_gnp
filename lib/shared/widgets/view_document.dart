import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:storybook_gnp/core/extensions/responsive_extension.dart';
import 'package:storybook_gnp/shared/widgets/appbar_phone.dart';

class ViewDocument extends StatelessWidget {
  const ViewDocument({super.key});

  static final GetPage page = GetPage(
    name: '/view-document',
    page: ViewDocument.new,
    transition: Transition.rightToLeft,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppbarPhone(
      title: 'Convenio',
    ),
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(),
          OutlinedButton(child: const Text('Descargar'), onPressed: () {}),
          SizedBox(height: context.scale(40, axis: ScaleAxis.height)),
        ],
      ),
    ),
  );
}
