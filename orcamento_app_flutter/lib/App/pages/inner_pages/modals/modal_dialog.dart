import 'package:flutter/material.dart';

class ModalDialog {
  static Future<dynamic> show({required BuildContext context, required String title, required Widget content}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              contentPadding: EdgeInsets.only(top: 30),
              content: content,
            ));
  }
}
