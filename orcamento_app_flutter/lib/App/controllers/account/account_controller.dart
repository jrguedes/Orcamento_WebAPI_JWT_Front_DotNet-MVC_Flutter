import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/account_api_service.dart';
import 'package:orcamento_app_flutter/App/services/cache/cache_service.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/value_state.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';

class AccountController {
  final AccountApiService service;
  final ValueState<bool> buttonTappedState = ValueState(false);
  final SignInStore signInStore;

  AccountController(this.service, this.signInStore);

  Future<void> signIn({String? email, String? password}) async {
    buttonTappedState.value = true;

    String userEmail = '';
    String userPassword = '';

    var jwtTokenInfo = await CacheService.getJWTTokenInfo();

    //PROVISORIO
    //depois verificar se o token é valido
    if (jwtTokenInfo != null) {
      signInStore.value = SuccessObjectState<TokenModel>(jwtTokenInfo);
      return;
    }

    if (email != null && password != null) {
      userEmail = email;
      userPassword = password;
    }

    await signInStore.signIn(LoginModel(email: userEmail, password: userPassword));

    if (signInStore.value is ErrorObjectState) {
      buttonTappedState.value = false;
    }
  }

  Future<void> logout() async {
    await service.logout();
    buttonTappedState.value = false;
    signInStore.value = InitialObjectState(null);
  }
}
