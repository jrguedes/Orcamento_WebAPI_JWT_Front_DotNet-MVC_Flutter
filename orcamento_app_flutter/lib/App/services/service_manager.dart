import 'package:flutter/widgets.dart';
import 'package:orcamento_app_flutter/App/controllers/account/account_controller.dart';
import 'package:orcamento_app_flutter/App/services/certificates/certificate_service.dart';
import '../controllers/home/home_controller.dart';

class ServiceManager {
  //late final OrcamentoController orcamentoController = OrcamentoController();
  late final AccountController accountController = AccountController();

  ServiceManager();

  Future<void> initializeServices() async {
    await CertificateService().initService();
    await accountController.signIn();
  }
}
