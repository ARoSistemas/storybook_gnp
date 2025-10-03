import 'dart:convert';
import 'dart:developer';

import 'package:storybook_gnp/core/config/constans.dart';
import 'package:storybook_gnp/core/services/network/api_call.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';

/// Ejemplo de implementación de ApiCall con endpoints dinámicos
///
/// Esta clase demuestra cómo usar tu nueva implementación de ApiCall
/// con endpoints y URIs completamente dinámicos desde constants.dart
class ApiCallExample {
  final ApiCallAbstract _apiCall = ApiCallImpl();

  /// Ejemplo: GET request con endpoint dinámico
  Future<ApiResponse<ApiFailure, ApiSuccess>> getMovies() => _apiCall.call(
    baseUri: baseUrl, // desde constants.dart
    endpoint: '/3/movie/popular', // endpoint dinámico
    body: '',
    epName: 'GetPopularMovies',
    queryParameters: {
      'api_key': 'apiKey',
      'language': 'es-ES',
    },
    bearer: '',
  );

  /// Ejemplo: POST request con endpoint dinámico
  Future<ApiResponse<ApiFailure, ApiSuccess>> createUser(
    Map<String, dynamic> userData,
  ) => _apiCall.call(
    baseUri: baseUrl, // desde constants.dart
    endpoint: '/users', // endpoint dinámico
    body: jsonEncode(userData),
    epName: 'CreateUser',
    method: HttpMethod.post,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    bearer: '',
  );

  /// Ejemplo: PUT request con endpoint dinámico
  Future<ApiResponse<ApiFailure, ApiSuccess>> updateUser(
    String userId,
    Map<String, dynamic> userData,
  ) => _apiCall.call(
    baseUri: baseUrl, // desde constants.dart
    endpoint: '/users/$userId', // endpoint dinámico con parámetro
    body: jsonEncode(userData),
    epName: 'UpdateUser',
    method: HttpMethod.put,
    bearer: '',
  );

  /// Ejemplo: DELETE request con endpoint dinámico
  Future<ApiResponse<ApiFailure, ApiSuccess>> deleteUser(String userId) =>
      _apiCall.call(
        baseUri: baseUrl, // desde constants.dart
        endpoint: '/users/$userId', // endpoint dinámico con parámetro
        body: '',
        epName: 'DeleteUser',
        method: HttpMethod.delete,
        bearer: '',
      );

  /// Ejemplo: Uso con manejo de respuesta
  Future<void> exampleUsage() async {
    final ApiResponse<ApiFailure, ApiSuccess> response = await getMovies();

    response.when(
      (failure) {
        log('Error: ${failure.message}');
        log('Código: ${failure.code}');
      },
      (success) {
        log('Éxito: ${success.data}');
        log('Código: ${success.code}');
      },
    );
  }
}

/// Ejemplo de uso directo sin clase wrapper
Future<void> directUsageExample() async {
  final ApiCallAbstract apiCall = ApiCallImpl();

  // Llamada directa con endpoints dinámicos desde constants.dart
  final ApiResponse<ApiFailure, ApiSuccess> response = await apiCall.call(
    baseUri: baseUrl, // URI base desde constants.dart
    endpoint: '/3/discover/movie', // endpoint específico
    body: '',
    epName: 'DiscoverMovies',
    queryParameters: {
      'api_key': 'apiKey',
      'sort_by': 'popularity.desc',
    },
    bearer: '',
  );

  // Manejo de respuesta
  if (response.isFailure) {
    log('Request failed: ${response.failure?.message}');
  } else {
    log('Request successful: ${response.success?.data}');
  }
}
