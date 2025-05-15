import 'package:flutter/material.dart';

void showBottomSnackbar({
  required String message,
  required BuildContext context,
  required bool isError,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
