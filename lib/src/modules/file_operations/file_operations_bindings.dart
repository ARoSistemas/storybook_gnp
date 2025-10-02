import 'package:get/get.dart';
import 'package:storybook_gnp/shared/services/files/file_service.dart';
import 'package:storybook_gnp/src/modules/file_operations/file_operations_controller.dart';

/// Bindings for file operations module
/// Following the same pattern as login_bindings.dart
class FileOperationsBindings extends Bindings {
  @override
  void dependencies() {
    // Inyectar el servicio de archivos
    Get
      ..lazyPut<FileService>(
        FileService.new,
        fenix: true,
      )
      // Inyectar el controlador
      ..lazyPut<FileOperationsController>(
        FileOperationsController.new,
      );
  }
}
