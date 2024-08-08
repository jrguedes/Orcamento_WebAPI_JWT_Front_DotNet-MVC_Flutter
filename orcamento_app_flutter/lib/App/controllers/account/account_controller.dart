import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';

class AccountController {
  final AccountAPIService _service = AccountAPIService();
  final ValueState<bool> buttonTappedState = ValueState(false);

  Future<TokenModel?> signIn({required String email, required String password}) async {
    buttonTappedState.value = true;
    var tokenModel = await _service.signIn(LoginModel(email: email, password: password));
    if (tokenModel == null) {
      buttonTappedState.value = false;
    }
    return tokenModel;
  }

  Future<void> logout() async {
    await _service.logout();
  }
}
