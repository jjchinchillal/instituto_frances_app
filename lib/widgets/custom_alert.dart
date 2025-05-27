import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

enum AlertType { success, warning, error }

class CustomAlert {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required AlertType type,
  }) {
    Color contentColor;
    Icon icon;

    switch (type) {
      case AlertType.success:
        contentColor = AppColors.success;
        icon = Icon(Icons.check_circle_outline, color: contentColor, size: 60);
        break;
      case AlertType.warning:
        contentColor = AppColors.warning;
        icon = Icon(Icons.warning_amber_rounded, color: contentColor, size: 60);
        break;
      case AlertType.error:
        contentColor = AppColors.error;
        icon = Icon(Icons.error_outline, color: contentColor, size: 60);
        break;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: contentColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black, // descripción en negro
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: contentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
