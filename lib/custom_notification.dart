import 'package:flutter/material.dart';

/// Enum for different types of custom snackbars
enum AlertType { success, warning, info, error }

/// Custom notification widget
/// Displays a customizable notification message
/// with optional title, action button, and close button.
class CustomNotification extends StatelessWidget {
  final AlertType type;
  final bool hasShadow;
  final String message;
  final String? title;
  final bool? showCloseButton;
  final VoidCallback? onAction;
  final String? actionLabel;
  final VoidCallback? onClose;

  const CustomNotification({
    super.key,
    required this.type,
    this.hasShadow = true,
    required this.message,
    this.title,
    this.showCloseButton,
    this.onAction,
    this.actionLabel,
    this.onClose,
  });

  /// Background color based on the type of notification
  Color get _backgroundColor {
    switch (type) {
      case AlertType.success:
        return Colors.green.shade50;
      case AlertType.warning:
        return Colors.orange.shade50;
      case AlertType.info:
        return Colors.blue.shade50;
      case AlertType.error:
        return Colors.red.shade50;
    }
  }

  /// Icon color based on the type of notification
  Color get _iconColor {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      case AlertType.error:
        return Colors.red;
    }
  }

  /// Icon data based on the type of notification
  IconData get _icon {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.info:
        return Icons.info;
      case AlertType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 600, minHeight: 60),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _iconColor.withValues(alpha: 0.3)),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(_icon, color: _iconColor),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _iconColor,
                      ),
                    ),
                  Text(message),
                ],
              ),
            ),
            if (onAction != null)
              TextButton(
                onPressed: onAction,
                child: Text(
                  actionLabel ?? 'Action',
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            if (showCloseButton == true)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.orange),
                onPressed: onClose,
              ),
          ],
        ),
      ),
    );
  }
}
