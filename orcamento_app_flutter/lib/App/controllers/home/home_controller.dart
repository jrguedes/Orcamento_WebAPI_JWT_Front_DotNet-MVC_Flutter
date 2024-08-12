import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../services/service_manager.dart';

typedef TAnimateToPage(int page, {required Duration duration, required Curve curve});

class HomeController {
  final TAnimateToPage animateToPage;
  late final ServiceManager _serviceManager = GetIt.I.get<ServiceManager>();
  final ValueNotifier<int> _indexPage = ValueNotifier(3);
  ValueNotifier<int> get indexPageState => _indexPage;

  HomeController({required this.animateToPage});

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 4) {
      _indexPage.value = index;
    }
  }
}
