import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storybook_gnp/core/config/constans.dart';
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

abstract class ApiCallAbstract extends GetConnect {
  Future<ApiResponse<ApiFailure, ApiSuccess>> call({
    required String endpoint,
    required String body,
    String epName = '-|',
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'UTF-8',
    },
    Map<String, String> queryParameters = const {},
  });

  String getBaseUri(String env, String ep);
}

class ApiCallImpl extends GetConnect implements ApiCallAbstract {
  ApiCallImpl(this._endpoint);
  final String _endpoint;

  @override
  @mustCallSuper
  void onInit() {
    final String uri = getBaseUri(env, _endpoint);
    httpClient.baseUrl = uri;
    httpClient.timeout = const Duration(seconds: 20);
    super.onInit();
  }

  @override
  Future<ApiResponse<ApiFailure, ApiSuccess>> call({
    required String endpoint,
    required String body,
    String epName = '-|',
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'UTF-8',
    },
    Map<String, String> queryParameters = const {},
  }) {
    // const timeout = Duration(seconds: 15);

    final DateTime startTime = DateTime.now();
    String responseApiWithChartSet = '';
    Map<String, dynamic> logs = {'startTime': startTime.toString()};
    StackTrace? stackTrace;

    const Response petitionResponse = Response(statusCode: 500);

    // final Uri url = Uri.parse(uri);
    Map<String, String> headers = {};
    try {
      headers = {...headers, 'Authorization': 'Bearer apiKey'};
      logs = {
        ...logs,
        'url': '${httpClient.baseUrl}',
        'queryParameters': queryParameters,
      };
      logs = {...logs, 'headers': headers};

      switch (method) {
        case HttpMethod.get:
        // petitionResponse = await _client
        //     .get(url, headers: headers)
        //     .timeout(timeout);

        case HttpMethod.post:
          // petitionResponse = await _client
          //     .post(url, headers: headers, body: body)
          //     .timeout(timeout);
          final Future<Response> a = httpClient.post(
            httpClient.baseUrl,
            body: body,
            contentType: contentType,
            headers: headers,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress,
          );

        default:
        //     petitionResponse = await _client
        //         .get(url, headers: headers)
        //         .timeout(timeout);
      }

      logs = {
        ...logs,
        'body': (body == 'mock') ? body : jsonDecode(body),
        'Response::':
            '**************************************************************',
        'Response code:': petitionResponse.statusCode,
      };

      /// Change charSet UTF-8
      responseApiWithChartSet = utf8.decode(petitionResponse.bodyBytes);

      logs = {...logs, 'Response body': jsonDecode(responseApiWithChartSet)};

      if (petitionResponse.statusCode == 200) {
        //. Success root request
        return ApiResponse.success(
          ApiSuccess(
            code: petitionResponse.statusCode,
            data: resApiWithChartSet,
          ),
        );
      } else {
        //. Failure root request
        final ApiFailure resFailure = ApiFailure.fromJson(resApiWithChartSet);
        return ApiResponse.failure(
          ApiFailure(
            code: petitionResponse.statusCode,
            message: resFailure.message,
          ),
        );
      }
    } catch (e, s) {
      stackTrace = s;
      logs = {...logs, 'error': e.toString()};

      if (e is ClientException || e.toString().contains('SocketException')) {
        return ApiResponse.failure(
          ApiFailure(code: petitionResponse.statusCode, message: e.toString()),
        );
      } else {
        return ApiResponse.failure(
          ApiFailure(code: e.hashCode, message: e.toString()),
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
      //     '$epName~$body~$resApiWithChartSet~${startTime.toString().substring(0, 22)} -> ${endTime.toString().substring(0, 22)}~$timeElapsed~$uri~$queryParameters~${jsonEncode(headers)}',
      //   );

      // _userPrefs.resHttp = oldData;
      // }
      // coverage:ignore-end

      ///  Delete this snippet when finish
      if (kDebugMode) {
        log('''
            $epName
            Endpoint ::-> $endpoint
            Url :: -> $uri
            --------------------------------------------------------------
              ${const JsonEncoder.withIndent(' ').convert(logs)}
            --------------------------------------------------------------
            ''', stackTrace: stackTrace);
      }
    }

    /// End class
  }

  @override
  String getBaseUri(String env, String ep) {
    throw UnimplementedError();
  }
}
