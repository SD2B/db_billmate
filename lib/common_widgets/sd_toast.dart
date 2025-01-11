import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SDToast {
  static void showToast(BuildContext context, {String? title, required String description, required ToastificationType type}) {
    toastification.show(
      context: context,
      type: type,
      title: Text(title ?? type.name.toUpperCase()),
      description: Text(description),
      primaryColor: Colors.white,
      autoCloseDuration: const Duration(seconds: 3),
      progressBarTheme: ProgressIndicatorThemeData(
        color: type == ToastificationType.success
            ? Colors.green
            : type == ToastificationType.info
                ? Colors.blue
                : type == ToastificationType.warning
                    ? Colors.orange
                    : Colors.red,
      ),
      showProgressBar: true,
      backgroundColor: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
              ? Colors.blue
              : type == ToastificationType.warning
                  ? Colors.orange
                  : Colors.red,
      foregroundColor: Colors.white,
    );
  }
}
