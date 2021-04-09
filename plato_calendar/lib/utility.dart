import 'package:flutter/material.dart';

// #1 하단에 잠시 텍스트 뜨게 하는 코드
void showMessage(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));

    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
}