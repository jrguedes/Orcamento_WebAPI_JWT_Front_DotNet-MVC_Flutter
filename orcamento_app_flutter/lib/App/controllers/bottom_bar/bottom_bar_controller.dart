import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:orcamento_app_flutter/App/data/constants/pages.dart';

typedef TAnimateToPage = Function(int page, {required Duration duration, required Curve curve});

class BottomBarController {
  final TAnimateToPage animateToPage;
  final ValueNotifier<int> _indexPage = ValueNotifier(HOME_PAGE);
  ValueNotifier<int> get indexPageState => _indexPage;

  BottomBarController(this.animateToPage);

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 3) {
      _indexPage.value = index;
    }
  }
}
