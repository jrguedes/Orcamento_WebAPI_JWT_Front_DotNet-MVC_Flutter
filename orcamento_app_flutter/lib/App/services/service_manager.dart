import 'package:flutter/widgets.dart';
import '../controllers/home/home_controller.dart';
import '../controllers/orcamento/orcamento_controller.dart';

class ServiceManager {
  late final PageController pageController = PageController(initialPage: 0);
  late final HomeController homeController = HomeController(animateToPage: pageController.animateToPage);
  late final OrcamentoController orcamentoController = OrcamentoController();

  ServiceManager();

  Future<void> initializeServices() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
