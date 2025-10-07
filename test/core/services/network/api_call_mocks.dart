import 'package:get/get_connect/connect.dart';
import 'package:mockito/mockito.dart';
import 'package:storybook_gnp/core/services/network/api_call.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';

// Clase mock para ApiCallAbstract
class MockApiCall extends Mock implements ApiCallAbstract {}

// Clase mock para GetConnect (para casos avanzados)
class MockGetConnect extends Mock implements GetConnect {}

// Clase mock para Response (respuesta de GetConnect)
class MockResponse<T> extends Mock implements Response<T> {}

// Datos de prueba para respuestas exitosas
class ApiCallTestData {
  static const String validBaseUri = 'https://api.test.com';
  static const String validEndpoint = '/users';
  static const String validBearerToken = 'valid-bearer-token';
  static const String invalidBearerToken = 'invalid-bearer-token';

  static const Map<String, dynamic> validPostData = {
    'name': 'John Doe',
    'email': 'john@example.com',
    'age': 30,
  };

  static const Map<String, dynamic> validPutData = {
    'id': 1,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'age': 25,
  };

  static const Map<String, dynamic> successResponseData = {
    'id': 1,
    'name': 'John Doe',
    'email': 'john@example.com',
    'message': 'Success',
  };

  static const Map<String, dynamic> errorResponseData = {
    'error': 'Bad Request',
    'message': 'Invalid data provided',
    'code': 400,
  };

  // URLs de prueba para diferentes escenarios
  static const String validFileDownloadUrl = '/files/document.pdf';
  static const String invalidUrl = '/invalid-endpoint';
  static const String timeoutUrl = '/timeout-endpoint';

  // Headers de prueba
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Map<String, String> customHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Custom-Header': 'custom-value',
  };

  // Respuestas JSON de ejemplo
  static const String successJson =
      '{"success": true, "message": "Operation completed"}';
  static const String errorJson =
      '{"error": true, "message": "Operation failed"}';
  static const String usersJson =
      '{"users": [{"id": 1, "name": "John"}], "total": 1}';
  static const String createdJson = '{"created": true, "id": 123}';
  static const String updatedJson = '{"updated": true, "id": 123}';
  static const String deletedJson = '{"deleted": true, "id": 123}';
  static const String downloadData =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=';

  // ===== DATOS ADICIONALES PARA PRUEBAS ESPECÍFICAS =====

  // Content-Types para pruebas de archivos
  static const String pdfContentType = 'application/pdf';
  static const String imageContentType = 'image/png';
  static const String jsonContentType = 'application/json';
  static const String octetStreamContentType = 'application/octet-stream';
  static const String textContentType = 'text/plain';

  // Content-Disposition headers
  static const String attachmentDisposition = 'attachment; filename="file.pdf"';
  static const String inlineDisposition = 'inline';

  // Headers con Authorization
  static const Map<String, String> headersWithAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer valid-bearer-token',
  };

  // Query parameters de ejemplo
  static const Map<String, String> sampleQueryParams = {
    'page': '1',
    'limit': '10',
    'sort': 'name',
  };

  // Bodies de ejemplo para diferentes métodos HTTP
  static const String postBody = '{"name": "John", "email": "john@test.com"}';
  static const String putBody =
      '{"id": 1, "name": "Jane", "email": "jane@test.com"}';
  static const String patchBody = '{"name": "Updated Name"}';
  static const String emptyBody = '';
  static const String invalidJsonBody = '{"invalid": json}';

  // Respuestas de error específicas
  static const Map<String, dynamic> error400Data = {
    'error': 'Bad Request',
    'message': 'Invalid parameters',
    'code': 400,
  };

  static const Map<String, dynamic> error404Data = {
    'error': 'Not Found',
    'message': 'Resource not found',
    'code': 404,
  };

  static const Map<String, dynamic> error500Data = {
    'error': 'Internal Server Error',
    'message': 'Server error occurred',
    'code': 500,
  };

  // Datos para pruebas de bytes y charset
  static const String utf8Text = 'Texto con acentos: áéíóú ñ 中文';
  static const String base64ImageData =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=';

  // Mensajes de excepción
  static const String socketExceptionMsg = 'SocketException: Connection failed';
  static const String timeoutExceptionMsg = 'TimeoutException: Request timeout';
  static const String handshakeExceptionMsg =
      'HandshakeException: Certificate error';
  static const String formatExceptionMsg = 'FormatException: Invalid format';
  static const String unexpectedExceptionMsg = 'Unexpected error occurred';
}

// Helpers para crear respuestas mock
class ApiCallMockHelpers {
  /// Crea una respuesta exitosa mock
  static Response<Map<String, dynamic>> createSuccessResponse({
    Map<String, dynamic>? body,
    int statusCode = 200,
    String? statusText,
  }) {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(
      mockResponse.body,
    ).thenReturn(body ?? ApiCallTestData.successResponseData);
    when(mockResponse.statusCode).thenReturn(statusCode);
    when(mockResponse.statusText).thenReturn(statusText ?? 'OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    return mockResponse;
  }

  /// Crea una respuesta de error mock
  static Response<Map<String, dynamic>> createErrorResponse({
    Map<String, dynamic>? body,
    int statusCode = 400,
    String? statusText,
  }) {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(
      mockResponse.body,
    ).thenReturn(body ?? ApiCallTestData.errorResponseData);
    when(mockResponse.statusCode).thenReturn(statusCode);
    when(mockResponse.statusText).thenReturn(statusText ?? 'Bad Request');
    when(mockResponse.hasError).thenReturn(true);
    when(mockResponse.isOk).thenReturn(false);
    return mockResponse;
  }

  /// Crea un ApiSuccess mock
  static ApiSuccess createMockApiSuccess({
    String? data,
    int? code,
  }) => ApiSuccess(
    code: code ?? 200,
    data: data ?? ApiCallTestData.successJson,
  );

  /// Crea un ApiFailure mock
  static ApiFailure createMockApiFailure({
    String? message,
    int? statusCode,
    String? status,
    String? description,
  }) => ApiFailure(
    code: statusCode ?? 400,
    message: message ?? 'Operation failed',
    status: status ?? 'error',
    description: description ?? 'Request failed',
  );

  // ===== MOCKS ESPECÍFICOS PARA PRUEBAS HTTP =====

  /// Mock para respuesta exitosa GET
  static Response<Map<String, dynamic>> createGetSuccessResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'users': [], 'total': 0});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(mockResponse.headers).thenReturn({'content-type': 'application/json'});
    when(mockResponse.bodyBytes).thenReturn(
      Stream.value([123, 34, 117, 115, 101, 114, 115, 34, 58, 91, 93, 125]),
    ); // JSON bytes
    return mockResponse;
  }

  /// Mock para respuesta exitosa POST
  static Response<Map<String, dynamic>> createPostSuccessResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'created': true, 'id': 123});
    when(mockResponse.statusCode).thenReturn(201);
    when(mockResponse.statusText).thenReturn('Created');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(mockResponse.headers).thenReturn({'content-type': 'application/json'});
    return mockResponse;
  }

  /// Mock para respuesta exitosa PUT
  static Response<Map<String, dynamic>> createPutSuccessResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'updated': true, 'id': 123});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    return mockResponse;
  }

  /// Mock para respuesta exitosa PATCH
  static Response<Map<String, dynamic>> createPatchSuccessResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'patched': true, 'id': 123});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    return mockResponse;
  }

  /// Mock para respuesta exitosa DELETE
  static Response<Map<String, dynamic>> createDeleteSuccessResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'deleted': true, 'id': 123});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    return mockResponse;
  }

  // ===== MOCKS PARA MANEJO DE ARCHIVOS =====

  /// Mock para descarga de archivo PDF
  static Response<Map<String, dynamic>> createPdfDownloadResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn(null);
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(mockResponse.headers).thenReturn({
      'content-type': ApiCallTestData.pdfContentType,
      'content-disposition': ApiCallTestData.attachmentDisposition,
    });
    when(
      mockResponse.bodyBytes,
    ).thenReturn(Stream.value([80, 68, 70, 45, 49, 46, 52])); // PDF bytes
    return mockResponse;
  }

  /// Mock para descarga de imagen
  static Response<Map<String, dynamic>> createImageDownloadResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn(null);
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(mockResponse.headers).thenReturn({
      'content-type': ApiCallTestData.imageContentType,
    });
    when(
      mockResponse.bodyBytes,
    ).thenReturn(Stream.value([137, 80, 78, 71, 13, 10, 26, 10])); // PNG bytes
    return mockResponse;
  }

  // ===== MOCKS PARA RESPUESTAS DE ERROR =====

  /// Mock para error 400
  static Response<Map<String, dynamic>> createError400Response() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn(ApiCallTestData.error400Data);
    when(mockResponse.statusCode).thenReturn(400);
    when(mockResponse.statusText).thenReturn('Bad Request');
    when(mockResponse.hasError).thenReturn(true);
    when(mockResponse.isOk).thenReturn(false);
    return mockResponse;
  }

  /// Mock para error 404
  static Response<Map<String, dynamic>> createError404Response() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn(ApiCallTestData.error404Data);
    when(mockResponse.statusCode).thenReturn(404);
    when(mockResponse.statusText).thenReturn('Not Found');
    when(mockResponse.hasError).thenReturn(true);
    when(mockResponse.isOk).thenReturn(false);
    return mockResponse;
  }

  /// Mock para error 500
  static Response<Map<String, dynamic>> createError500Response() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn(ApiCallTestData.error500Data);
    when(mockResponse.statusCode).thenReturn(500);
    when(mockResponse.statusText).thenReturn('Internal Server Error');
    when(mockResponse.hasError).thenReturn(true);
    when(mockResponse.isOk).thenReturn(false);
    return mockResponse;
  }

  // ===== MOCKS PARA RESPUESTAS UTF-8 Y CHARSET =====

  /// Mock para respuesta con caracteres UTF-8
  static Response<Map<String, dynamic>> createUtf8Response() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'message': ApiCallTestData.utf8Text});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(
      mockResponse.headers,
    ).thenReturn({'content-type': 'application/json; charset=utf-8'});
    return mockResponse;
  }

  /// Mock para respuesta con bodyString cuando bodyBytes es null
  static Response<Map<String, dynamic>> createBodyStringResponse() {
    final mockResponse = MockResponse<Map<String, dynamic>>();
    when(mockResponse.body).thenReturn({'data': 'test'});
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.statusText).thenReturn('OK');
    when(mockResponse.hasError).thenReturn(false);
    when(mockResponse.isOk).thenReturn(true);
    when(mockResponse.bodyBytes).thenReturn(null);
    when(mockResponse.bodyString).thenReturn('{"data": "test"}');
    return mockResponse;
  }

  // ===== MOCKS PARA PROGRESO DE UPLOAD =====

  /// Crea un callback de progreso de ejemplo para las pruebas
  // En las pruebas reales, esto será null o un callback real
  // Por ahora retornamos null para las pruebas
  static Progress? createMockProgressCallback() => null;

  /// Configura un mock básico con respuestas de éxito
  static void setupSuccessfulMock(MockApiCall mockApiCall) {
    // Mock para getBaseUri
    when(
      mockApiCall.getBaseUri('https://api.test.com', '/users'),
    ).thenReturn('https://api.test.com/users');
    when(
      mockApiCall.getBaseUri('https://api.test.com/', '/users'),
    ).thenReturn('https://api.test.com/users');
    when(
      mockApiCall.getBaseUri('https://api.test.com', 'users'),
    ).thenReturn('https://api.test.com/users');
    when(
      mockApiCall.getBaseUri('https://api.test.com/', 'users'),
    ).thenReturn('https://api.test.com/users');
  }

  /// Configura mocks para escenarios de error
  static void setupErrorMock(MockApiCall mockApiCall) {
    // Mantener getBaseUri funcional incluso en errores
    when(
      mockApiCall.getBaseUri('https://api.test.com', '/invalid'),
    ).thenReturn('https://api.test.com/invalid');
  }
}
