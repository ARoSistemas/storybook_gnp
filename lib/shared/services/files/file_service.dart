import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/config/constans.dart';
import 'package:storybook_gnp/core/services/network/api_call.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';

/// Abstract class defining the contract for file operations
abstract class FileServiceAbstract {
  /// Upload a file with progress tracking
  Future<ApiResponse<ApiFailure, ApiSuccess>> uploadFile({
    required File file,
    required String bearerToken,
    String? fileName,
    Function(double percent)? onUploadProgress,
  });

  /// Download a file with progress tracking
  Future<ApiResponse<ApiFailure, ApiSuccess>> downloadFile({
    required String fileId,
    required String bearerToken,
    Function(double percent)? onDownloadProgress,
  });

  /// Save downloaded file to device
  Future<bool> saveDownloadedFile({
    required String base64Data,
    required String fileName,
    required String savePath,
  });
}

/// Implementation of file service using ApiCall
class FileService extends GetxService implements FileServiceAbstract {
  final ApiCallAbstract _apiCall = ApiCallImpl();

  @override
  Future<ApiResponse<ApiFailure, ApiSuccess>> uploadFile({
    required File file,
    required String bearerToken,
    String? fileName,
    Function(double percent)? onUploadProgress,
  }) async {
    try {
      final Uint8List fileBytes = await file.readAsBytes();
      final String base64Content = base64Encode(fileBytes);
      final String fileNameToUse = fileName ?? file.path.split('/').last;

      final Map<String, Object> uploadData = {
        'filename': fileNameToUse,
        'content': base64Content,
        'size': fileBytes.length,
        'mimeType': _getMimeType(fileNameToUse),
        'uploadedAt': DateTime.now().toIso8601String(),
      };

      return await _apiCall.call(
        baseUri: baseUrl, // desde constants.dart
        endpoint: '/files/upload',
        bearer: bearerToken,
        body: jsonEncode(uploadData),
        epName: 'UploadFile',
        method: HttpMethod.post,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        uploadProgress: onUploadProgress != null
            ? (percent) => onUploadProgress(percent)
            : null,
      );
    } on Exception catch (e) {
      return ApiResponse.failure(
        ApiFailure(
          message: 'Error preparing file for upload: $e',
        ),
      );
    }
  }

  // Nota: Para agregar downloadProgress necesitarías modificar ApiCall
  // Por ahora uso el método downloadFile existente
  @override
  Future<ApiResponse<ApiFailure, ApiSuccess>> downloadFile({
    required String fileId,
    required String bearerToken,
    Function(double percent)? onDownloadProgress,
  }) => _apiCall.downloadFile(
    baseUri: baseUrl,
    endpoint: '/files/$fileId/download',
    bearer: bearerToken,
    epName: 'DownloadFile',
    queryParameters: {
      'format': 'original',
    },
  );

  @override
  Future<bool> saveDownloadedFile({
    required String base64Data,
    required String fileName,
    required String savePath,
  }) async {
    try {
      final Uint8List bytes = base64Decode(base64Data);
      final file = File(savePath);

      // Crear directorio si no existe
      final Directory directory = file.parent;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      await file.writeAsBytes(bytes);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Utility method to get MIME type
  String _getMimeType(String fileName) {
    final String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'txt':
        return 'text/plain';
      case 'json':
        return 'application/json';
      default:
        return 'application/octet-stream';
    }
  }
}
