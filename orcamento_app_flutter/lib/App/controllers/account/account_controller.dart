import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';

class AccountController {
  final AccountApiService service;
  final ValueState<bool> buttonTappedState = ValueState(false);
  final SignInStore signInStore;

  AccountController(this.service, this.signInStore);

  Future<void> signIn({String? email, String? password, verifyCachedLogin = false}) async {
    buttonTappedState.value = !verifyCachedLogin;

    String userEmail = '';
    String userPassword = '';

    if (email != null && password != null) {
      userEmail = email;
      userPassword = password;
    }

    await signInStore.signIn(LoginModel(email: userEmail, password: userPassword), verifyCachedLogin);
    buttonTappedState.value = false;
  }

  Future<void> logout() async {
    await service.logout();
    buttonTappedState.value = false;
    signInStore.value = InitialObjectState(null);
  }
}
