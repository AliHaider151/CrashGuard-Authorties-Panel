import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackbar(bool isError, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? Colors.red[700]! : Colors.green[700]!,
    textColor: Colors.white,
    fontSize: 14,
    webShowClose: true,
    webBgColor: isError ? "#d32f2f" : "#388e3c",
  );
}
