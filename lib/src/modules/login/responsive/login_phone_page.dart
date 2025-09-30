part of '../../login/login_page.dart';

class _LoginPhonePage extends StatelessWidget {
  _LoginPhonePage();

  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Form(
      key: _c.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [
                  SizedBox(height: context.scale(80, axis: ScaleAxis.height)),
                  const LogoGnp(),
                  SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                  if (!_c.isEmailEntered.value)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Identificate',
                        style: Get.textTheme.titleSmall,
                      ),
                    ),
                  if (_c.isEmailEntered.value)
                    Column(
                      children: [
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
                          onPressed: _c.toggleInputFields,
                          child: Text(
                            'Cambiar usuario',
                            style: Get.textTheme.titleSmall?.copyWith(
                              color: ColorPalette.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
                  if (_c.isEmailEntered.value)
                    Obx(
                      () => TextFormField(
                        obscureText: !_c.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: 'Contraseña',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _c.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _c.togglePasswordVisibility,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        controller: _c.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                  if (!_c.isEmailEntered.value)
                    TextFormField(
                      controller: _c.emailController,
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
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextButton(
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
                  SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
                  ElevatedButton(
                    child: const Text('Continuar'),
                    onPressed: () async {
                      if (!_c.formKey.currentState!.validate()) {
                        return;
                      }

                      if (!_c.isEmailEntered.value) {
                        _c.toggleInputFields();
                      } else {
                        await _c.loginController(
                          _c.emailController.text,
                          _c.passwordController.text,
                        );
                      }
                    },
                  ),
                  if (_c.isEmailEntered.value)
                    Column(
                      children: [
                        SizedBox(
                          height: context.scale(20, axis: ScaleAxis.height),
                        ),
                        TextButton(
                          child: Text(
                            'Ingresa con biometricos',
                            style: Get.textTheme.titleSmall?.copyWith(
                              color: ColorPalette.primary,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  SizedBox(height: context.scale(25, axis: ScaleAxis.height)),
                  const Divider(color: ColorPalette.textField),
                  SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  TextButton(
                    onPressed: () {},
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
          ],
        ),
      ),
    ),
  );
}
