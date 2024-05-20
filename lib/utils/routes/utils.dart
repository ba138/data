import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';

class Utils {
  static void focusNode(
      BuildContext context, FocusNode current, FocusNode focusNext) {
    current.unfocus();
    FocusScope.of(context).requestFocus(focusNext);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.blueAccent.shade100,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        borderRadius: BorderRadius.circular(20.0),
        titleSize: 20.0,
        padding: const EdgeInsets.all(16.0),
        positionOffset: 20,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
          size: 30.0,
        ),
      )..show(context),
    );
  }

  static snackBar(String mesg, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: const Text(
          'error occure',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
