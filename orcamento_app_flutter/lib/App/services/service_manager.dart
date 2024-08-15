import 'package:orcamento_app_flutter/App/controllers/account/account_controller.dart';
import 'package:orcamento_app_flutter/App/services/certificates/certificate_service.dart';
import 'package:intl/date_symbol_data_local.dart';

class ServiceManager {
  final AccountController accountController;
  ServiceManager(this.accountController);

  Future<bool> initializeServices() async {
    await CertificateService().initService();
    await initializeDateFormatting('pt_BR', null);
    await accountController.signIn();
    return true;
  }
}
