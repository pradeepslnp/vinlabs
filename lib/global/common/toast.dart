import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message, required bool isthis}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isthis ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Color submitColor = Colors.red;
