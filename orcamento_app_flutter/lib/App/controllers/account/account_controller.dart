import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';

class AccountController {
  final AccountAPIService _service = AccountAPIService();

  Future<TokenModel?> signIn({required String email, required String password}) async {
    var tokenModel = await _service.signIn(LoginModel(email: email, password: password));
    return tokenModel;
  }

  Future<void> logout() async {
    await _service.logout();
  }
}
