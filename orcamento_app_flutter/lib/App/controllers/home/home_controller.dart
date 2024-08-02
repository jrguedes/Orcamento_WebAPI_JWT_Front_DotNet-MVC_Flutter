import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

//import '../../services/service_manager.dart';

typedef TAnimateToPage(int page, {required Duration duration, required Curve curve});

class HomeController {
  final TAnimateToPage animateToPage;
  //late final ServiceManager _serviceManager = GetIt.I.get<ServiceManager>();
  ValueNotifier<int> _indexPage = ValueNotifier(0);
  ValueNotifier<int> get indexPageState => _indexPage;

  HomeController({required this.animateToPage});

  Future<void> _login() async {
    /*
    if (_firebaseAuth.currentUser == null) {
      await _firebaseAuth.signInWithEmailAndPassword(email: 'jrguedes.ja@gmail.com', password: '1234567');
    }*/
  }

  Future<void> _loadOrcamentos() async {}

  void convexAppBarTap(int index) {
    animateToPage(index, curve: Curves.easeOutSine, duration: const Duration(microseconds: 500));
    if (index <= 3) {
      _indexPage.value = index;
    }
  }
}
