import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

typedef TAnimateToPage(int page, {required Duration duration, required Curve curve});

class HomeController {
  final TAnimateToPage animateToPage;
  final ValueNotifier<int> _indexPage = ValueNotifier(3);
  ValueNotifier<int> get indexPageState => _indexPage;

  HomeController(this.animateToPage);

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 4) {
      _indexPage.value = index;
    }
  }
}
