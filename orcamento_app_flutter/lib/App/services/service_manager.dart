import 'package:orcamento_app_flutter/App/controllers/account/account_controller.dart';
import 'package:orcamento_app_flutter/App/services/certificates/certificate_service.dart';

class ServiceManager {
  final AccountController accountController;
  ServiceManager(this.accountController);

  Future<void> initializeServices() async {
    await CertificateService().initService();
    await accountController.signIn();
  }
}
