import 'package:flutter/cupertino.dart';

class CustomCupertinoActivityIndicator extends StatelessWidget {
  final Color? color;
  final double radius;
  final bool animating;
  const CustomCupertinoActivityIndicator({super.key, this.color, this.radius = 10, this.animating = true});

  @override
  Widget build(BuildContext context) {
    CupertinoActivityIndicator(animating: animating, radius: radius, color: color);
    return CupertinoActivityIndicator(radius: 20.0, color: color);
  }
}
