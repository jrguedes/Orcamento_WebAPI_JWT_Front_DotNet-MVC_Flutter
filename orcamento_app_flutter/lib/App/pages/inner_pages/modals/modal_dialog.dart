import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ModalDialog {
  static Future<dynamic> show({required BuildContext context, required String title, required Widget content}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 0, indent: 30, endIndent: 30),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 30),
              content: content,
            ));
  }
}
