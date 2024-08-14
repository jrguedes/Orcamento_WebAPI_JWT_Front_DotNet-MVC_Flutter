import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

typedef TAnimateToPage = Function(int page, {required Duration duration, required Curve curve});

class BottomBarController {
  final TAnimateToPage animateToPage;
  final ValueNotifier<int> _indexPage = ValueNotifier(0);
  ValueNotifier<int> get indexPageState => _indexPage;

  BottomBarController(this.animateToPage);

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 4) {
      _indexPage.value = index;
    }
  }
}
