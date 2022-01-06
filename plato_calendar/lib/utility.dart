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
void showToastMessageCenter(String message){
  Fluttertoast.cancel().then((value) => {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG)
  });
}

void showToastMessageTop(String message){
  Fluttertoast.cancel().then((value) => {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG)
  });
}

void closeToastMessage(){
  Fluttertoast.cancel();
}


/// 지정된 초마다 신호 보내는 timer
Stream<bool> timer(int second) async* {
  while(true){
    yield true;
    await Future.delayed(Duration(seconds: second));
  }
}