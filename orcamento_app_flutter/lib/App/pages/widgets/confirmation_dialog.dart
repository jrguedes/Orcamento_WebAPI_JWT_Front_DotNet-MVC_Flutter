import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<void> show(
      {required BuildContext context,
      required String title,
      required String description,
      void Function()? okPress,
      void Function()? cancelPress}) async {
    await AwesomeDialog(
      btnOkColor: Theme.of(context).primaryColor,
      btnCancelColor: const Color.fromARGB(209, 156, 8, 8),
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: okPress,
      btnCancelOnPress: cancelPress,
    ).show();
  }
}
