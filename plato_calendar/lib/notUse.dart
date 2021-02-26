import 'package:flutter/material.dart';

// do not use this

BuildContext ctx;

Widget build(BuildContext context) {
  ctx = context;
}

void showMessage(String msg) {
    final snackbar = SnackBar(content: Text(msg));

    Scaffold.of(ctx)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
  }