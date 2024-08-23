import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class ConfirmationDialog {
  static Future<void> show(
      {required BuildContext context,
      required String title,
      required String description,
      void Function()? okPress,
      void Function()? cancelPress}) async {
    await AwesomeDialog(
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
