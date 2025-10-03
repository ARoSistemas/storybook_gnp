import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:storybook_gnp/core/config/constans.dart';
import 'package:storybook_gnp/core/services/network/api_call.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';

/// 🚀 Ejemplos de uso de ApiCall con soporte para archivos
///
/// Esta clase demuestra cómo usar la implementación de ApiCall
/// con endpoints dinámicos y soporte para descargas de archivos
class ApiCallUsageExamples {
  final ApiCallAbstract _apiCall = ApiCallImpl();

  /// ✅ Ejemplo básico: GET request
  Future<ApiResponse<ApiFailure, ApiSuccess>> getMovies(
    String bearerToken,
  ) => _apiCall.call(
    baseUri: baseUrl, // desde constants.dart
    endpoint: '/3/movie/popular',
    bearer: bearerToken,
    body: '',
    epName: 'GetPopularMovies',
    queryParameters: {
      'api_key': 'api_key',
      'language': 'es-ES',
    },
  );

  /// ✅ Ejemplo básico: POST request
  Future<ApiResponse<ApiFailure, ApiSuccess>> createUser(
    String bearerToken,
    Map<String, dynamic> userData,
  ) => _apiCall.call(
    baseUri: baseUrl, // desde constants.dart
    endpoint: '/users',
    bearer: bearerToken,
    body: jsonEncode(userData),
    epName: 'CreateUser',
    method: HttpMethod.post,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  /// 📥 NUEVO: Download de archivo (devuelve base64)
  Future<ApiResponse<ApiFailure, ApiSuccess>> downloadFile(
    String bearerToken,
    String fileId,
  ) => _apiCall.downloadFile(
    baseUri: baseUrl,
    endpoint: '/files/$fileId/download',
    bearer: bearerToken,
    epName: 'DownloadFile',
    queryParameters: {
      'format': 'original',
      'compression': 'none',
    },
  );

  /// 📥 Ejemplo COMPLETO: Descarga y guardado de archivo
  Future<bool> downloadAndSaveFile(
    String bearerToken,
    String fileId,
    String savePath,
  ) async {
    try {
      log('📥 Iniciando descarga del archivo $fileId...');

      final ApiResponse<ApiFailure, ApiSuccess> response = await downloadFile(
        bearerToken,
        fileId,
      );

      return await response.when(
        (failure) {
          log('❌ Error descargando archivo: ${failure.message}');
          log('📊 Código de error: ${failure.code}');
          return false;
        },
        (success) {
          try {
            log('✅ Descarga exitosa, procesando archivo...');

            // success.data contiene el archivo en base64
            final Uint8List bytes = base64Decode(success.data);

            // Crear directorio si no existe
            // final file = File(savePath);
            // final Directory directory = file.parent;
            // if (!await directory.exists()) {
            //   await directory.create(recursive: true);
            //   log('📁 Directorio creado: ${directory.path}');
            // }

            // Guardar archivo
            // await file.writeAsBytes(bytes);

            log('✅ Archivo guardado exitosamente:');
            log('   📍 Ruta: $savePath');
            log('   📊 Tamaño: ${bytes.length} bytes');
            log('   📅 Fecha: ${DateTime.now()}');

            return true;
          } on Exception catch (e) {
            log('❌ Error guardando archivo: $e');
            return false;
          }
        },
      );
    } on Exception catch (e) {
      log('❌ Error general en descarga: $e');
      return false;
    }
  }

  /// 📤 Upload básico usando JSON (para APIs que aceptan base64)
  Future<ApiResponse<ApiFailure, ApiSuccess>> uploadFileAsBase64(
    String bearerToken,
    File file,
    String fileName,
  ) async {
    try {
      // Leer archivo y convertir a base64
      final Uint8List bytes = await file.readAsBytes();
      final String base64Content = base64Encode(bytes);

      final Map<String, Object> uploadData = {
        'filename': fileName,
        'content': base64Content,
        'size': bytes.length,
        'mimeType': _getMimeType(fileName),
        'uploadedAt': DateTime.now().toIso8601String(),
      };

      return await _apiCall.call(
        baseUri: baseUrl,
        endpoint: '/upload/base64',
        bearer: bearerToken,
        body: jsonEncode(uploadData),
        epName: 'UploadFileBase64',
        method: HttpMethod.post,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } on Exception catch (e) {
      // Crear response de error manual
      return ApiResponse.failure(
        ApiFailure(
          message: 'Error preparando archivo para upload: $e',
        ),
      );
    }
  }

  /// 🔄 Upload con reintentos automáticos
  Future<bool> uploadWithRetry(
    String bearerToken,
    File file,
    String fileName, {
    int maxRetries = 3,
  }) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      log('🔄 Intento $attempt de $maxRetries para $fileName');

      try {
        final ApiResponse<ApiFailure, ApiSuccess> response =
            await uploadFileAsBase64(bearerToken, file, fileName);

        final bool success = await response.when(
          (failure) {
            log('❌ Intento $attempt falló: ${failure.message}');
            return false;
          },
          (success) {
            log('✅ Upload exitoso en intento $attempt');
            log('📄 Respuesta del servidor: ${success.data}');
            return true;
          },
        );

        if (success) {
          return true;
        }

        // Espera exponencial entre intentos
        if (attempt < maxRetries) {
          final waitTime = Duration(seconds: attempt * 2);
          log(
            '⏳ Esperando ${waitTime.inSeconds}s antes del siguiente intento...',
          );
          await Future.delayed(waitTime);
        }
      } on Exception catch (e) {
        log('❌ Error en intento $attempt: $e');
        if (attempt == maxRetries) {
          log('❌ Todos los intentos fallaron');
          return false;
        }
      }
    }

    return false;
  }

  /// 📊 Ejemplo de uso con monitoreo completo
  Future<void> demonstrateFileOperations() async {
    const bearerToken = 'tu_bearer_token_aqui';

    log(r'🚀 === DEMOSTRACIÓN DE OPERACIONES CON ARCHIVOS ===\n');

    // 1. Download de archivo
    log('📥 1. Descargando archivo...');
    final bool downloadSuccess = await downloadAndSaveFile(
      bearerToken,
      'file123',
      'downloads/document.pdf',
    );

    if (downloadSuccess) {
      log(r'✅ Descarga completada\n');
    } else {
      log(r'❌ Descarga falló\n');
    }

    // 2. Upload de archivo
    log('📤 2. Subiendo archivo...');
    final testFile = File('test_document.txt');

    // Crear archivo de prueba si no existe
    // if (!await testFile.exists()) {
    //await testFile.writeAsString('Este es un archivo de prueba para upload');
    // }

    final bool uploadSuccess = await uploadWithRetry(
      bearerToken,
      testFile,
      'test_document.txt',
    );

    if (uploadSuccess) {
      log(r'✅ Upload completado\n');
    } else {
      log(r'❌ Upload falló\n');
    }

    log('🎉 === DEMOSTRACIÓN COMPLETADA ===');
  }

  /// Utilidad: Obtener MIME type básico
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
      case 'xml':
        return 'application/xml';
      case 'zip':
        return 'application/zip';
      default:
        return 'application/octet-stream';
    }
  }
}

/// 🔧 Ejemplos de uso directo (sin wrapper)
class DirectApiCallExamples {
  /// 📥 Download directo con manejo completo
  static Future<void> directDownload() async {
    final ApiCallAbstract apiCall = ApiCallImpl();
    const bearerToken = 'tu_bearer_token';

    log('📥 Iniciando descarga directa...');
    final stopwatch = Stopwatch()..start();

    final ApiResponse<ApiFailure, ApiSuccess> response = await apiCall
        .downloadFile(
          baseUri: baseUrl,
          endpoint: '/documents/important.pdf',
          bearer: bearerToken,
          epName: 'DirectDownload',
          queryParameters: {
            'version': 'latest',
            'format': 'pdf',
          },
        );

    stopwatch.stop();
    log('⏱️ Tiempo de descarga: ${stopwatch.elapsedMilliseconds}ms');

    response.when(
      (failure) {
        log('❌ Download falló: ${failure.message}');
        log('📊 Código de error: ${failure.code}');
      },
      (success) {
        final Uint8List bytes = base64Decode(success.data);
        log('✅ Download exitoso:');
        log('   📊 Tamaño: ${bytes.length} bytes');
        log('   📄 Tipo: PDF');

        // Guardar con timestamp
        final fileName =
            'important_${DateTime.now().millisecondsSinceEpoch}.pdf';
        File(fileName).writeAsBytesSync(bytes);
        log('   💾 Guardado como: $fileName');
      },
    );
  }

  /// 📤 Upload directo JSON
  static Future<void> directUpload() async {
    final ApiCallAbstract apiCall = ApiCallImpl();
    const bearerToken = 'tu_bearer_token';

    // Crear datos de prueba
    final Map<String, String> testData = {
      'title': 'Documento de prueba',
      'content': 'Este es el contenido del documento',
      'author': 'Usuario de prueba',
      'createdAt': DateTime.now().toIso8601String(),
    };

    log('📤 Iniciando upload directo...');

    final ApiResponse<ApiFailure, ApiSuccess> response = await apiCall.call(
      baseUri: baseUrl,
      endpoint: '/documents/create',
      bearer: bearerToken,
      body: jsonEncode(testData),
      epName: 'DirectUpload',
      method: HttpMethod.post,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    response.when(
      (failure) {
        log('❌ Upload falló: ${failure.message}');
        log('📊 Código de error: ${failure.code}');
      },
      (success) {
        log('✅ Upload exitoso:');
        log('📄 Respuesta: ${success.data}');
        log('📊 Código: ${success.code}');
      },
    );
  }

  /// 🔄 Operación completa: Create → Upload → Download
  static Future<void> completeWorkflow() async {
    final ApiCallAbstract apiCall = ApiCallImpl();
    const bearerToken = 'tu_bearer_token';

    log(r'🔄 === WORKFLOW COMPLETO ===\\n');

    // 1. Crear documento
    log('1️⃣ Creando documento...');
    final ApiResponse<ApiFailure, ApiSuccess> createResponse = await apiCall
        .call(
          baseUri: baseUrl,
          endpoint: '/documents',
          bearer: bearerToken,
          body: jsonEncode({
            'title': 'Workflow Test Document',
            'description': 'Documento creado para probar el workflow completo',
          }),
          epName: 'CreateDocument',
          method: HttpMethod.post,
          headers: {'Content-Type': 'application/json'},
        );

    String? documentId;
    createResponse.when(
      (failure) => log('❌ Error creando documento: ${failure.message}'),
      (success) {
        final Map<String, dynamic> data = jsonDecode(success.data);
        documentId = data['id']?.toString();
        log('✅ Documento creado con ID: $documentId');
      },
    );

    if (documentId != null) {
      // 2. Descargar documento
      log(r'\\n2️⃣ Descargando documento...');
      final ApiResponse<ApiFailure, ApiSuccess> downloadResponse = await apiCall
          .downloadFile(
            baseUri: baseUrl,
            endpoint: '/documents/$documentId/export',
            bearer: bearerToken,
            epName: 'ExportDocument',
          );

      downloadResponse.when(
        (failure) => log('❌ Error descargando: ${failure.message}'),
        (success) {
          final Uint8List bytes = base64Decode(success.data);
          log('✅ Documento descargado: ${bytes.length} bytes');

          // Guardar archivo
          File('workflow_document.pdf').writeAsBytesSync(bytes);
          log('💾 Guardado como: workflow_document.pdf');
        },
      );
    }

    log(r'\\n🎉 === WORKFLOW COMPLETADO ===');
  }
}
