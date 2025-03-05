import 'package:craft_school/utils/craft_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ShowDialogs {
 




  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor:CraftColors.neutralBlue850,
        backgroundColor: Colors.white,
        fontSize: 14.0);
  }


}
