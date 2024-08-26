import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

typedef TAnimateToPage = Function(int page, {required Duration duration, required Curve curve});

class BottomBarController {
  final TAnimateToPage animateToPage;
  final GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  BottomBarController(this.animateToPage);

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 3) {
      appBarKey.currentState?.animateTo(index);
    }
  }
}
