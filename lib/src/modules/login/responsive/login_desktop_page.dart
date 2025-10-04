part of '../login_page.dart';

class _LoginDesktopPage extends GetView<LoginController> {
  const _LoginDesktopPage();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: SizedBox(
        width: 600,
        height: 1200,
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  /// Logo
                  const Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 30),
                    child: LogoGnp(),
                  ),

                  ///
                  if (!controller.isEmailEntered.value)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Identificate',
                        style: Get.textTheme.titleSmall,
                      ),
                    ),

                  /// Show welcome message and name if email is entered
                  if (controller.isEmailEntered.value) ...[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '!Bienvenido!',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Juan Perez',
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: ColorPalette.textPrimary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.scale(5, axis: ScaleAxis.height),
                    ),
                    TextButton(
                      onPressed: controller.toggleInputFields,
                      child: Text(
                        'Cambiar usuario',
                        style: Get.textTheme.titleSmall?.copyWith(
                          color: ColorPalette.primary,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  if (controller.isEmailEntered.value)
                    TextFormField(
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Contraseña',
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),

                  if (!controller.isEmailEntered.value)
                    TextFormField(
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.isEmail) {
                          return 'Ingresa un correo valido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Correo eléctronico',
                        hintText: 'Correo eléctronico',
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        // Add Dialog
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                      ),
                    ),
                  ),

                  /// Continue Button
                  if (!controller.isLoading.value)
                    ElevatedButton(
                      child: const Text('Continuar'),
                      onPressed: () async {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }

                        if (!controller.isEmailEntered.value) {
                          controller.toggleInputFields();
                        } else {
                          await controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          );
                        }
                      },
                    ),
                  if (controller.isLoading.value)
                    const CircularProgressIndicator(),

                  /// Biometric Login Button
                  if (controller.isEmailEntered.value) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: Text(
                          'Ingresa con biometricos',
                          style: Get.textTheme.titleSmall?.copyWith(
                            color: ColorPalette.primary,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],

                  const Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Divider(color: ColorPalette.textField),
                  ),

                  /// Register Section
                  TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        ColorPalette.textPrimary,
                      ),
                      textStyle: WidgetStateProperty.all(
                        Get.textTheme.titleMedium,
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      alignment: Alignment.center,
                    ),
                    child: const Text('¿No tienes una cuenta?'),
                  ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  OutlinedButton(
                    onPressed: () => Get.toNamed('/registro'),
                    child: const Text('Registrate ahora'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
