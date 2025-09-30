import 'package:get/get_connect/http/src/response/response.dart';
import 'package:storybook_gnp/core/services/network/network_service.dart';
import 'package:storybook_gnp/shared/models/outgoing/login_response_model.dart';

class AuthServices extends ApiBaseProvider {
  @override
  final String url =
      'https://admonproveedoressalud-services-qa.gnp.com.mx/admonproveedores';

  @override
  final String contextPath = '/conveniomedicos';

  Future loginService(String email, String password) async {
    const String loginEnpoint = '/login';

    final Map<String, dynamic> body = {
      'mail': email,
      'password': password,
      'tipousuario': 'administrador',
    };

    final Response response = await post(
      loginEnpoint,
      body,
    );

    if (response.body != null) {
      final Map<String, dynamic> jsonBody = response.body['payload'];
      return LoginRespondeModel.fromJson(jsonBody);
    }

    if (response.body == null) {
      throw Exception('La respuesta del login no se pudo decodificar');
    }
  }
}
