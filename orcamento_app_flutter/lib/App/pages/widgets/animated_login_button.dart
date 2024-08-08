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
        width: selected ? 50 : 350,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 123, 86, 196),
          borderRadius: BorderRadius.circular(selected ? 25 : 10),
        ),
        alignment: Alignment.center,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: const FlutterLogo(size: 30),
      ),
    );
  }
}
