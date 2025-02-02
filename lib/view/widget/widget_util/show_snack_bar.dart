import 'dart:math';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Text(message),
      showCloseIcon: true,
      width: min(400.0, MediaQuery.of(context).size.width),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction()
      duration: const Duration(seconds: 2),
      actionOverflowThreshold: 0.25);

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
