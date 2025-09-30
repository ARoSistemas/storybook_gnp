import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:storybook_gnp/shared/widgets/custom_notification.dart';

abstract class NotificationAbstract {
  void showNotification({
    required AlertType type,
    required String message,
    bool hasShadow = true,
    String? title,
    bool showCloseButton = false,
    VoidCallback? onAction,
    String? actionLabel,
    Duration duration,
  });

  void removeCurrent();
}

class NotificationService extends GetxService implements NotificationAbstract {
  /// Current active overlay entry
  OverlayEntry? _currentOverlay;

  /// Method to show a custom notification as an overlay
  @override
  void showNotification({
    required AlertType type,
    required String message,
    bool hasShadow = true,
    String? title,
    bool showCloseButton = false,
    VoidCallback? onAction,
    String? actionLabel,
    Duration duration = const Duration(seconds: 3),
  }) {
    /// Close previous notification if exists
    removeCurrent();

    /// Create new overlay entry
    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width * (kIsWeb ? 0.2 : 0.4),
            child: CustomNotification(
              type: type,
              hasShadow: hasShadow,
              title: title,
              message: message,
              showCloseButton: showCloseButton,
              onAction: onAction,
              actionLabel: actionLabel,
              onClose: removeCurrent,
            ),
          ),
        ),
      ),
    );

    /// Store the current overlay
    _currentOverlay = overlay;

    /// Check that the overlay context is available
    final BuildContext? overlayContext = Get.overlayContext;

    /// If yes, use it to insert the overlay
    if (overlayContext != null) {
      Overlay.of(overlayContext, rootOverlay: true).insert(overlay);
    } else {
      /// if not, try with the main context
      final BuildContext? context = Get.context;
      if (context != null) {
        Overlay.of(context, rootOverlay: true).insert(overlay);
      } else {
        /// If no contexts are available, do not show the notification
        _currentOverlay = null;
        return;
      }
    }

    /// If no close button => auto close
    if (!showCloseButton) {
      Future.delayed(duration, removeCurrent);
    }
  }

  /// Method to remove the current overlay if exists
  @override
  void removeCurrent() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
