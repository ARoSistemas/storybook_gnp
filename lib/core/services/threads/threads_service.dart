import 'package:get/get.dart';
import 'package:storybook_gnp/core/utils/exception_manager.dart';
import 'package:storybook_gnp/core/utils/logger.dart';

class ThreadsService extends GetxService {
  Future<void> execute({
    required Future<void> Function() func,
    bool rethrowException = false,
  }) async {
    try {
      await func.call();
    } on Exception catch (e) {
      logger.e('Exception: $e');

      if (rethrowException) {
        rethrow;
      }

      ExceptionManager.handleError(e);
    }
  }
}
