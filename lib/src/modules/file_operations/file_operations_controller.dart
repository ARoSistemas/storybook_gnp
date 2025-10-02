import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/core/services/network/api_response.dart';
import 'package:storybook_gnp/core/services/network/api_response_failure.dart';
import 'package:storybook_gnp/core/services/network/api_response_success.dart';
import 'package:storybook_gnp/shared/services/files/file_service.dart';

/// Controller for file operations with progress tracking
class FileOperationsController extends GetxController {
  final FileServiceAbstract _fileService = Get.find<FileService>();

  // Upload state
  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxString uploadStatus = ''.obs;

  // Download state
  final RxBool isDownloading = false.obs;
  final RxDouble downloadProgress = 0.0.obs;
  final RxString downloadStatus = ''.obs;

  // File list (example)
  final RxList<Map<String, dynamic>> uploadedFiles =
      <Map<String, dynamic>>[].obs;

  /// Upload file with progress tracking
  Future<void> uploadFile(File file, String bearerToken) async {
    try {
      isUploading.value = true;
      uploadProgress.value = 0.0;
      uploadStatus.value = 'Preparando archivo...';

      final String fileName = file.path.split('/').last;

      final ApiResponse<ApiFailure, ApiSuccess> response = await _fileService
          .uploadFile(
            file: file,
            bearerToken: bearerToken,
            fileName: fileName,
            onUploadProgress: (percent) {
              uploadProgress.value = percent;
              uploadStatus.value = 'Subiendo: ${percent.toStringAsFixed(1)}%';
            },
          );

      response.when(
        (failure) {
          uploadStatus.value = 'Error: ${failure.message}';
          _showErrorSnackbar('Error subiendo archivo', failure.message);
        },
        (success) {
          uploadStatus.value = '¡Archivo subido exitosamente!';
          uploadProgress.value = 100.0;

          // Agregar archivo a la lista
          final Map<String, Object> fileData = {
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'name': fileName,
            'size': file.lengthSync(),
            'uploadedAt': DateTime.now(),
          };
          uploadedFiles.add(fileData);

          _showSuccessSnackbar('Éxito', 'Archivo subido correctamente');

          // Reset después de 2 segundos
          Future.delayed(const Duration(seconds: 2), () {
            uploadProgress.value = 0.0;
            uploadStatus.value = '';
          });
        },
      );
    } on Exception catch (e) {
      uploadStatus.value = 'Error inesperado: $e';
      _showErrorSnackbar('Error', 'Error inesperado al subir archivo');
    } finally {
      isUploading.value = false;
    }
  }

  /// Download file with progress tracking
  Future<void> downloadFile(
    String fileId,
    String fileName,
    String bearerToken,
  ) async {
    try {
      isDownloading.value = true;
      downloadProgress.value = 0.0;
      downloadStatus.value = 'Iniciando descarga...';

      final ApiResponse<ApiFailure, ApiSuccess> response = await _fileService
          .downloadFile(
            fileId: fileId,
            bearerToken: bearerToken,
            onDownloadProgress: (percent) {
              downloadProgress.value = percent;
              downloadStatus.value =
                  'Descargando: ${percent.toStringAsFixed(1)}%';
            },
          );

      await response.when(
        (failure) {
          downloadStatus.value = 'Error: ${failure.message}';
          _showErrorSnackbar('Error descargando archivo', failure.message);
        },
        (success) async {
          downloadStatus.value = 'Guardando archivo...';
          downloadProgress.value = 100.0;

          // Guardar archivo en el dispositivo
          final savePath = '/storage/emulated/0/Download/$fileName';
          final bool saved = await _fileService.saveDownloadedFile(
            base64Data: success.data,
            fileName: fileName,
            savePath: savePath,
          );

          if (saved) {
            downloadStatus.value = '¡Archivo descargado exitosamente!';
            _showSuccessSnackbar('Éxito', 'Archivo guardado en: $savePath');
          } else {
            downloadStatus.value = 'Error guardando archivo';
            _showErrorSnackbar('Error', 'No se pudo guardar el archivo');
          }

          // Reset después de 2 segundos
          Future.delayed(const Duration(seconds: 2), () {
            downloadProgress.value = 0.0;
            downloadStatus.value = '';
          });
        },
      );
    } on Exception catch (e) {
      downloadStatus.value = 'Error inesperado: $e';
      _showErrorSnackbar('Error', 'Error inesperado al descargar archivo');
    } finally {
      isDownloading.value = false;
    }
  }

  /// Remove file from list (UI only)
  void removeFile(int index) {
    if (index >= 0 && index < uploadedFiles.length) {
      uploadedFiles.removeAt(index);
      _showSuccessSnackbar('Eliminado', 'Archivo removido de la lista');
    }
  }

  /// Show success snackbar
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  /// Show error snackbar
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
