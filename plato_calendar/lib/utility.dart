import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// #1 하단에 잠시 텍스트 뜨게 하는 코드
void showMessage(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));

    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
}

// #2 원하는 위치에 toast 메세지
void showToastMessage(String message){
  Fluttertoast.cancel().then((value) => {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG)
  });
}