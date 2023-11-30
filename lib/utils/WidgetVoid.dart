import 'package:flutter/material.dart';

class WidgetVoid {
  static void showSnackBar(BuildContext context, String message,
      {backgroundColor = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
