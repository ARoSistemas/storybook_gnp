import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/src/modules/login/login_controller.dart';
import 'package:storybook_gnp/src/modules/login/login_model.dart';

class HomePage extends GetView<LoginController> {
  const HomePage({super.key});

  static final GetPage page = GetPage(
    name: '/home',
    page: HomePage.new,
    transition: Transition.rightToLeft,
  );

  @override
  Widget build(BuildContext context) {
    final UserModel user = controller.currentUser.payload;
    final Claims claims = controller.currentUser.payload.token.jwtLogin.claims;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page from Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            ListTile(
              title: const Text('nombreCompleto'),
              subtitle: Text(user.nombreCompleto),
            ),
            ListTile(
              title: const Text('Token.Jwt '),
              subtitle: Text(user.token.jwt),
            ),
            ListTile(
              title: const Text(
                'Token.refreshtoken',
              ),
              subtitle: Text(user.token.refreshtoken),
            ),

            ListTile(
              title: const Text('codAfiliacion '),
              subtitle: Text(user.codAfiliacion),
            ),

            ListTile(
              title: const Text('rfc'),
              subtitle: Text(user.rfc),
            ),

            ListTile(
              title: const Text('nombreCompleto'),
              subtitle: Text(user.nombreCompleto),
            ),

            ListTile(
              title: const Text('especialidad'),
              subtitle: Text(user.especialidad),
            ),

            ListTile(
              title: const Text('estado'),
              subtitle: Text(user.estado),
            ),

            ListTile(
              title: const Text('circulo'),
              subtitle: Text(user.circulo),
            ),

            ListTile(
              title: const Text('tabulador'),
              subtitle: Text(user.tabulador),
            ),

            ListTile(
              title: const Text('estatus'),
              subtitle: Text(user.estatus),
            ),

            ListTile(
              title: const Text('vigenciaConvenio '),
              subtitle: Text(user.vigenciaConvenio),
            ),

            ListTile(
              title: const Text('banVerConvenio'),
              subtitle: Text(user.banVerConvenio.toString()),
            ),

            ListTile(
              title: const Text(
                'banDescargaConvenio',
              ),
              subtitle: Text(user.banDescargaConvenio.toString()),
            ),

            ListTile(
              title: const Text('uid'),
              subtitle: Text(user.uid),
            ),

            ListTile(
              title: const Text('banVerAviso'),
              subtitle: Text(user.banVerAviso.toString()),
            ),

            ListTile(
              title: const Text(
                'banConvenioActualizado',
              ),
              subtitle: Text(user.banConvenioActualizado.toString()),
            ),

            const Divider(),
            const Text('Claims'),
            const Divider(),

            ListTile(
              title: const Text('rol'),
              subtitle: Text(claims.rol),
            ),

            ListTile(
              title: const Text(
                'negociosOperables',
              ),
              subtitle: Text(claims.negociosOperables),
            ),

            ListTile(
              title: const Text(
                'idParticipante',
              ),
              subtitle: Text(claims.idParticipante),
            ),

            ListTile(
              title: const Text('mail'),
              subtitle: Text(claims.mail),
            ),

            ListTile(
              title: const Text('apeMaterno'),
              subtitle: Text(claims.apeMaterno),
            ),

            ListTile(
              title: const Text('givenName'),
              subtitle: Text(claims.givenName),
            ),

            ListTile(
              title: const Text('apePaterno'),
              subtitle: Text(claims.apePaterno),
            ),

            ListTile(
              title: const Text(
                'cuentaBloqueda ',
              ),
              subtitle: Text(claims.cuentaBloqueda.toString()),
            ),

            ListTile(
              title: const Text('tipoUsuario '),
              subtitle: Text(claims.tipoUsuario),
            ),
            ListTile(
              title: const Text('cedula '),
              subtitle: Text(claims.cedula),
            ),

            if (claims.roles.isNotEmpty)
              ...claims.roles.map(
                (rol) => Text('Rol: $rol'),
              ),
          ],
        ),
      ),
    );
  }
}
