import 'package:flutter/material.dart';

// #1 하단에 잠시 텍스트 뜨게 하는 코드
BuildContext ctx;

Widget build(BuildContext context) {
  ctx = context;
}

void showMessage(String msg) {
    final snackbar = SnackBar(content: Text(msg));

    ScaffoldMessenger.of(ctx)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
  }