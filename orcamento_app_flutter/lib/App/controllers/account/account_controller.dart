import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';
import 'package:orcamento_app_flutter/App/states/signin_state.dart';

class AccountController {
  final AccountAPIService _service = AccountAPIService();
  final ValueState<bool> buttonTappedState = ValueState(false);
  final SignInState signInState = SignInState();

  Future<void> signIn({required String email, required String password}) async {
    buttonTappedState.value = true;

    await signInState.signIn(LoginModel(email: email, password: password));
    if (signInState.value == null) {
      buttonTappedState.value = false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
  }
}
