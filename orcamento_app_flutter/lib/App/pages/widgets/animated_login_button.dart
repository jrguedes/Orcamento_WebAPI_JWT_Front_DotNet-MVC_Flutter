import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/custom_cupertino_activity_indicator.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';

class AnimatedLoginButton extends StatefulWidget {
  final Function onTap;
  final ValueState<bool> buttonTappedState;

  const AnimatedLoginButton({super.key, required this.onTap, required this.buttonTappedState});

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        widget.buttonTappedState.value = true;
        widget.onTap();
      },
      child: ValueListenableBuilder(
          valueListenable: widget.buttonTappedState,
          builder: (context, value, child) {
            return AnimatedContainer(
              width: widget.buttonTappedState.value ? 50 : size.width - 85,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF3b889a),
                borderRadius: BorderRadius.circular(widget.buttonTappedState.value ? 25 : 10),
              ),
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: widget.buttonTappedState.value
                  ? const CustomCupertinoActivityIndicator(color: CupertinoColors.activeOrange, radius: 20)
                  : const FaIcon(
                      FontAwesomeIcons.sackDollar,
                      color: Colors.amber,
                      size: 30,
                    ), //const FlutterLogo(size: 30),
            );
          }),
    );
  }
}
