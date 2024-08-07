import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';

class AccountController {
  final AccountAPIService _service = AccountAPIService();

  Future<void> getAccounts() async {
    var users = await _service.getAccounts();
  }

  Future<TokenModel?> signIn({required email, required senha}) async {
    var tokenModel = await _service.signIn(LoginModel(email: 'gerente@gerente.com', password: '1234'));
    String name = 'Bob';

    return tokenModel;
  }

  Future<void> logout() async {
    await _service.logout();
  }
}
