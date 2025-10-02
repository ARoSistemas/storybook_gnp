import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_gnp/src/modules/file_operations/file_operations_bindings.dart';
import 'package:storybook_gnp/src/modules/file_operations/file_operations_controller.dart';

/// Screen for demonstrating file operations with progress tracking
class FileOperationsScreen extends GetView<FileOperationsController> {
  const FileOperationsScreen({super.key});

  static final GetPage page = GetPage(
    name: '/file-operations',
    page: () => const FileOperationsScreen(),
    binding: FileOperationsBindings(),
  );

  @override
  Widget build(BuildContext context) {
    // Simulated bearer token (normally would come from auth service)
    const bearerToken = 'token';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operaciones con Archivos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload Section
            _buildUploadSection(bearerToken),

            const SizedBox(height: 24),

            // Download Section
            _buildDownloadSection(bearerToken),

            const SizedBox(height: 24),

            // Files List
            _buildFilesList(),
          ],
        ),
      ),
    );
  }

  /// Build upload section with progress
  Widget _buildUploadSection(String bearerToken) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.upload, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Subir Archivo',
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Upload button
          Obx(
            () => ElevatedButton(
              onPressed: controller.isUploading.value
                  ? null
                  : () => _pickAndUploadFile(bearerToken),
              child: controller.isUploading.value
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Subiendo...'),
                      ],
                    )
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder_open),
                        SizedBox(width: 8),
                        Text('Seleccionar Archivo'),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Upload progress
          Obx(() {
            if (controller.uploadProgress.value > 0 ||
                controller.isUploading.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: controller.uploadProgress.value / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.uploadStatus.value,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    ),
  );

  /// Build download section with progress
  Widget _buildDownloadSection(String bearerToken) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.download, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Descargar Archivo',
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Download button
          Obx(
            () => ElevatedButton(
              onPressed: controller.isDownloading.value
                  ? null
                  : () => _downloadSampleFile(bearerToken),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: controller.isDownloading.value
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Descargando...'),
                      ],
                    )
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_download),
                        SizedBox(width: 8),
                        Text('Descargar Ejemplo'),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Download progress
          Obx(() {
            if (controller.downloadProgress.value > 0 ||
                controller.isDownloading.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: controller.downloadProgress.value / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.downloadStatus.value,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    ),
  );

  /// Build uploaded files list
  Widget _buildFilesList() => Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.list, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Archivos Subidos',
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Obx(() {
                if (controller.uploadedFiles.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No hay archivos subidos',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.uploadedFiles.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> file =
                        controller.uploadedFiles[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.insert_drive_file),
                        title: Text(file['name']),
                        subtitle: Text(
                          'Tamaño: ${_formatFileSize(file['size'])} \n'
                          'Subido: ${_formatDateTime(file['uploadedAt'])}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.removeFile(index),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    ),
  );

  /// Pick and upload file
  Future<void> _pickAndUploadFile(String bearerToken) async {
    try {
      // Simulated file selection -
      // in real app you would use file_picker package
      // For demo purposes, create a test file
      final testFile = File('${Directory.systemTemp.path}/test_upload.txt');
      await testFile.writeAsString(
        'Este es un archivo de prueba creado en ${DateTime.now()} \n'
        'Contenido de ejemplo para demostrar el upload con progress.',
      );

      await controller.uploadFile(testFile, bearerToken);
    } on Exception catch (e) {
      Get.snackbar(
        'Error',
        'Error creando archivo de prueba: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Download sample file
  Future<void> _downloadSampleFile(String bearerToken) async {
    // Simulated file ID - in real app this would come from file list
    const fileId = 'sample_document_123';
    const fileName = 'sample_document.pdf';

    await controller.downloadFile(fileId, fileName, bearerToken);
  }

  /// Format file size
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Format date time
  String _formatDateTime(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year} '
      '${dateTime.hour.toString().padLeft(2, '0')}:'
      '${dateTime.minute.toString().padLeft(2, '0')}';
}
