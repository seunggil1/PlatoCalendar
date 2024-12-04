import 'package:flutter/material.dart';

void showMessage(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}