import 'package:flutter/material.dart';
class AppUtils {
  static void showSnackBar(String str, ScaffoldState context, {color = Colors.blue, textColor = Colors.black}) {
      context.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          str,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: color,
      ));
  }
}
