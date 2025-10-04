import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';

/// The `HttpMethod` enum defines various HTTP methods for API requests.
///
/// **Values:**
/// - `get`: Represents an HTTP GET request.
/// - `post`: Represents an HTTP POST request.
/// - `put`: Represents an HTTP PUT request.
/// - `patch`: Represents an HTTP PATCH request.
/// - `delete`: Represents an HTTP DELETE request.
/// - `other`: Represents any other HTTP method.
enum HttpMethod { get, post, put, patch, delete, other }

/// Abstract class defining the contract for API calls
///
/// This class outlines the methods and parameters required for making
/// API requests.
abstract class ApiCallAbstract extends GetConnect {
  /// Makes an API call with the specified parameters.
  ///
  /// Parameters:
  /// - `baseUri`: The base URI for the API.
  /// - `endpoint`: The specific endpoint for the API call.
  /// - `bearer`: The bearer token for authorization.
  /// - `body`: The request body as a string.
  /// - `epName`: A name for the endpoint, used for logging purposes.
  /// - `method`: The HTTP method to use for the request (default is GET).
  /// - `headers`: Additional headers to include in the request (default
  /// includes JSON content type).
  /// - `queryParameters`: Query parameters to include in the request (default
  ///  is empty).
  /// - `uploadProgress`: Optional progress callback for upload operations.
  Future<ApiResponse<ApiFailure, ApiSuccess>> call({
    required String baseUri,
    required String endpoint,
    required String bearer,
    required String body,
    String epName = '-|',
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'UTF-8',
    },
    Map<String, String> queryParameters = const {},
    Progress? uploadProgress,
  });

  /// Downloads a file from the specified endpoint.
  ///
  /// Parameters:
  /// - `baseUri`: The base URI for the API.
  /// - `endpoint`: The specific endpoint for the file download.
  /// - `bearer`: The bearer token for authorization.
  /// - `epName`: A name for the endpoint, used for logging purposes (default
  /// is 'FILE_DOWNLOAD').
  /// - `headers`: Additional headers to include in the request (default
  /// is empty).
  /// - `queryParameters`: Query parameters to include in the request (default
  /// is empty).
  Future<ApiResponse<ApiFailure, ApiSuccess>> downloadFile({
    required String baseUri,
    required String endpoint,
    required String bearer,
    String epName = 'FILE_DOWNLOAD',
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
  });

  /// Constructs the full base URI by combining the base URI and endpoint.
  ///
  /// This method ensures that the resulting URI is properly formatted.
  /// If the endpoint is not empty, it is appended to the base URI.
  String getBaseUri(String baseUri, String endpoint);
}

/// Concrete implementation of the `ApiCallAbstract` class
class ApiCallImpl extends GetConnect implements ApiCallAbstract {
  @override
  void onInit() {
    super.onInit();
    httpClient.timeout = const Duration(seconds: 20);
  }

  @override
  Future<ApiResponse<ApiFailure, ApiSuccess>> call({
    required String baseUri,
    required String endpoint,
    required String bearer,
    required String body,
    String epName = '-|',
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'UTF-8',
    },
    Map<String, String> queryParameters = const {},
    Progress? uploadProgress,
  }) async {
    final DateTime startTime = DateTime.now();
    String responseApiWithChartSet = '';
    Map<String, dynamic> logs = {'startTime': startTime.toString()};
    StackTrace? stackTrace;

    final String fullUrl = getBaseUri(baseUri, endpoint);
    Response? petitionResponse;

    /// Merge headers with Authorization
    final Map<String, String> finalHeaders = bearer.isNotEmpty
        ? {
            ...headers,
            'Authorization': 'Bearer $bearer',
          }
        : headers;

    try {
      logs = {
        ...logs,
        'method': method.toString().split('.').last,
        'url': fullUrl,
        'headers': finalHeaders,
        'body': body.isNotEmpty ? jsonDecode(body) : 'Empty body',
      };

      if (kDebugMode) {
        log('''
        **************************************************************
        Se hace la petición a la API::
        **************************************************************
${const JsonEncoder.withIndent(' ').convert(logs)}
        
        Esperando respuesta...
        --------------------------------------------------------------
        ''');
        logs = {};
      }

      /// Select HTTP method for the request

      switch (method) {
        case HttpMethod.get:
          petitionResponse = await httpClient.get(
            fullUrl,
            headers: finalHeaders,
            query: queryParameters,
          );

        case HttpMethod.post:
          petitionResponse = await httpClient.post(
            fullUrl,
            body: body,
            headers: finalHeaders,
            uploadProgress: uploadProgress,
          );

        case HttpMethod.put:
          petitionResponse = await httpClient.put(
            fullUrl,
            body: body,
            headers: finalHeaders,
            query: queryParameters,
            uploadProgress: uploadProgress,
          );

        case HttpMethod.patch:
          petitionResponse = await httpClient.patch(
            fullUrl,
            body: body,
            headers: finalHeaders,
            query: queryParameters,
            uploadProgress: uploadProgress,
          );

        case HttpMethod.delete:
          petitionResponse = await httpClient.delete(
            fullUrl,
            headers: finalHeaders,
            query: queryParameters,
          );
        case HttpMethod.other:
          petitionResponse = await httpClient.get(
            fullUrl,
            headers: finalHeaders,
            query: queryParameters,
          );
      }

      /// Handle response
      ///
      /// If there is an error in the response,
      /// log the error details and return a failure response.
      if (petitionResponse.hasError) {
        logs = {
          ...logs,
          'Response::':
              '**************************************************************',
          'Response code:': petitionResponse.statusCode,
          'error': petitionResponse.statusText ?? 'Unkown error',
        };

        return ApiResponse.failure(
          ApiFailure(
            code: petitionResponse.statusCode ?? 500,
            message: petitionResponse.statusText ?? 'Unkown error',
          ),
        );
      } else {
        /// Success response
        /// If the response is successful, process the response body
        /// and return a success response.
        logs = {
          ...logs,
          'Response code:': petitionResponse.statusCode,
        };

        /// Process response body with charset handling
        final String contentType =
            petitionResponse.headers?['content-type']?.toLowerCase() ?? '';
        final String contentDisposition =
            petitionResponse.headers?['content-disposition']?.toLowerCase() ??
            '';

        final bool isFileDownload =
            contentType.contains('application/octet-stream') ||
            contentType.contains('application/pdf') ||
            contentType.startsWith('image/') ||
            contentType.startsWith('video/') ||
            contentType.startsWith('audio/') ||
            contentType.contains('multipart/') ||
            contentDisposition.contains('attachment');

        /// Change charSet UTF-8 o manejar archivos
        if (petitionResponse.bodyBytes != null) {
          final List<List<int>> bodyBytesData = await petitionResponse
              .bodyBytes!
              .toList();

          final List<int> flattenedBytes = bodyBytesData
              .expand((x) => x)
              .toList();

          if (isFileDownload) {
            /// For files: return bytes as base64
            responseApiWithChartSet = base64Encode(flattenedBytes);
          } else {
            /// For JSON/text: decode as UTF-8
            responseApiWithChartSet = utf8.decode(flattenedBytes);
          }
        } else {
          responseApiWithChartSet = petitionResponse.bodyString ?? '';
        }

        logs = {
          ...logs,
          'Response body': isFileDownload
              ? '<File Content - ${responseApiWithChartSet.length} bytes>'
              : responseApiWithChartSet.isNotEmpty
              ? jsonDecode(responseApiWithChartSet)
              : '',
        };

        if (petitionResponse.statusCode! >= 200 &&
            petitionResponse.statusCode! <= 299) {
          //. Success root request
          return ApiResponse.success(
            ApiSuccess(
              code: petitionResponse.statusCode ?? 200,
              data: responseApiWithChartSet,
            ),
          );
        } else {
          //. Failure root request
          ApiFailure resFailure;
          try {
            resFailure = ApiFailure.fromJson(responseApiWithChartSet);
          } on FormatException catch (_) {
            resFailure = ApiFailure(
              code: petitionResponse.statusCode ?? 500,
              message: responseApiWithChartSet.isNotEmpty
                  ? responseApiWithChartSet
                  : 'Unknown error occurred',
            );
          }

          return ApiResponse.failure(
            ApiFailure(
              code: petitionResponse.statusCode ?? 500,
              message: resFailure.message,
            ),
          );
        }
      }
    } on FormatException catch (e, s) {
      stackTrace = s;
      logs = {...logs, 'error': e.toString()};
      final err = e.toString();

      if (err.contains('SocketException') ||
          err.contains('TimeoutException') ||
          err.contains('HandshakeException')) {
        return ApiResponse.failure(
          ApiFailure(
            code: petitionResponse?.statusCode ?? 0,
            message: 'Network error: $err',
          ),
        );
      } else {
        return ApiResponse.failure(
          ApiFailure(
            code: e.hashCode,
            message: 'Unexpected error: $err',
          ),
        );
      }
    } finally {
      final DateTime endTime = DateTime.now();
      final String timeElapsed = endTime.difference(startTime).toString();
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
        'TimeElapsed': timeElapsed,
      };

      /// Only for purpose QA
      // coverage:ignore-start

      // final List<String> oldData = _userPrefs.resHttp;

      // if (body != 'mock') {
      //   oldData.add(
      //     '$epName~$body~$responseApiWithChartSet~${startTime.toString()
      //  .substring(0, 22)} -> ${endTime.toString().substring(0, 22)}~
      // $timeElapsed~$fullUrl~$queryParameters~${jsonEncode(finalHeaders)}',
      //   );

      //   _userPrefs.resHttp = oldData;
      // }
      // coverage:ignore-end

      ///  Delete this snippet when finish
      if (kDebugMode) {
        log('''
${const JsonEncoder.withIndent(' ').convert(logs)}
            --------------------------------------------------------------
            ''', stackTrace: stackTrace);
      }
    }
  }

  @override
  Future<ApiResponse<ApiFailure, ApiSuccess>> downloadFile({
    required String baseUri,
    required String endpoint,
    required String bearer,
    String epName = 'FILE_DOWNLOAD',
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
  }) => call(
    baseUri: baseUri,
    endpoint: endpoint,
    bearer: bearer,
    body: '',
    epName: epName,
    headers: {
      ...headers,
      'Accept': '*/*', // Acepta cualquier tipo de archivo
    },
    queryParameters: queryParameters,
  );

  /// Returns the base URL for the API environment based on the specified kind.
  @override
  String getBaseUri(String baseUri, String endpoint) {
    if (baseUri.endsWith('/') && endpoint.startsWith('/')) {
      return baseUri + endpoint.substring(1);
    } else if (!baseUri.endsWith('/') && !endpoint.startsWith('/')) {
      return '$baseUri/$endpoint';
    } else {
      return baseUri + endpoint;
    }
  }
}

// Sobrescribir HttpClient para ignorar certificados
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) {
        if (kDebugMode) {
          print('⚠️ Ignorando certificado de $host');
          return true; // aceptar para debug
        }
        return false; // false para release - no ignorar -
      };
    return client;
  }
}
