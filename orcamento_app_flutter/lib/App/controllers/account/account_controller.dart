import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';

import '../../services/api/orcamento_api_service.dart';

class AccountController {
  final AccountAPIService _service = AccountAPIService();

  Future<void> getAccounts() async {
    var users = await _service.getAccounts();
  }

  Future<void> signIn() async {
    var tokenModel = await _service.signIn(LoginModel(email: 'gerente@gerente.com', password: '1234'));
    return;
  }
}
