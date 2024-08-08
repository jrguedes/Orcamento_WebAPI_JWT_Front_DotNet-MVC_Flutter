import 'package:flutter/material.dart';

class AnimatedLoginButton extends StatefulWidget {
  const AnimatedLoginButton({super.key});

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        width: selected ? 300 : 50,
        height: 50,
        decoration: BoxDecoration(
          color: selected ? const Color.fromARGB(255, 123, 86, 196) : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: const FlutterLogo(size: 30),
      ),
    );
  }
}
