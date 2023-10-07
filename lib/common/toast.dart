import 'package:flutter/material.dart';

enum ToastType { success, error, warning }

Future<void> showToast({
  required String message,
  required BuildContext context,
  ToastType type = ToastType.success,
}) async {
  var bgColor;

  switch (type) {
    case ToastType.success:
      bgColor = Colors.green;
    case ToastType.error:
      bgColor = Colors.red;
    case ToastType.warning:
      bgColor = Colors.amber;
  }

  final snackBar = SnackBar(
    content: Text(message),
    showCloseIcon: true,
    backgroundColor: bgColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
