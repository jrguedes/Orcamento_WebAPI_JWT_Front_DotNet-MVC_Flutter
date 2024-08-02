import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).dialogBackgroundColor); //Theme.of(context).backgroundColor);
  }
}
