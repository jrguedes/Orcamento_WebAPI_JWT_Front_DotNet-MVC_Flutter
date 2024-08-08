import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';

class AnimatedLoginButton extends StatefulWidget {
  final Function onTap;
  final ValueState<bool> buttonTappedState;

  const AnimatedLoginButton({super.key, required this.onTap, required this.buttonTappedState});

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  //bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*
        setState(() {
          selected = !selected;
        });
        */
        widget.buttonTappedState.value = true;
        widget.onTap();
      },
      child: ValueListenableBuilder(
          valueListenable: widget.buttonTappedState,
          builder: (context, value, child) {
            return AnimatedContainer(
              width: widget.buttonTappedState.value ? 50 : 350,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 86, 196),
                borderRadius: BorderRadius.circular(widget.buttonTappedState.value ? 25 : 10),
              ),
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: widget.buttonTappedState.value ? const CupertinoActivityIndicator() : const FlutterLogo(size: 30),
            );
          }),
    );
  }
}
