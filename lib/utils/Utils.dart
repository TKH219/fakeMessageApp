import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ColorUtils.dart';

class Utils {

  static void showToastMessage(String message,
      [ToastGravity gravity = ToastGravity.CENTER]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: gray5,
        textColor: Colors.black,
        fontSize: 15);
  }
}