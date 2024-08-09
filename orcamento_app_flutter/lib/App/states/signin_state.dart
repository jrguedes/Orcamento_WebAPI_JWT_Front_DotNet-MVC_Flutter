import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';

import '../services/api/account_api_service.dart';

class SignInState extends ValueNotifier<ObjectState<TokenModel?>> {
  late final AccountAPIService _service = AccountAPIService();
  SignInState() : super(InitialObjectState<TokenModel?>(null));

  Future<void> signIn(LoginModel login) async {
    value = LoadingObjectState();
    try {
      final jwtTokenInfo = await _service.signIn(login);
      if (jwtTokenInfo == null) {
        value = ErrorObjectState('Usuário ou senha inválidos!');
      } else {
        value = SuccessObjectState<TokenModel?>(jwtTokenInfo);
      }
    } catch (e) {
      value = ErrorObjectState('Há um problema de conexão com a API');
    }
  }
}
