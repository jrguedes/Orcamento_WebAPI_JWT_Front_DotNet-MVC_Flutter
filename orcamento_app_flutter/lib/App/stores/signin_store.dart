import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/login_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/exceptions/not_found_exception.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/stores/istore.dart';

import '../services/api/account_api_service.dart';

class SignInStore extends ValueNotifier<ObjectState<TokenModel?>> implements IStore {
  final AccountApiService service;
  SignInStore(this.service) : super(InitialObjectState<TokenModel?>(null));

  Future<void> logout(String cause) async {
    value = UnauthorizedObjectState<TokenModel?>(cause);

    //await service.logout();

    //value = InitialObjectState(null);
  }

  Future<void> signIn(LoginModel login, bool verifyCachedLogin) async {
    TokenModel? jwtTokenInfo;
    try {
      value = LoadingObjectState();

      jwtTokenInfo = await service.signIn(login);

      if (jwtTokenInfo == null) {
        value = InitialObjectState(null);
      } else {
        value = SuccessObjectState<TokenModel?>(jwtTokenInfo);
      }
    } on NotFoundException catch (e) {
      if (verifyCachedLogin) {
        value = InitialObjectState(null);
      } else {
        value = ErrorObjectState(e.message);
      }
    } catch (e) {
      value = ErrorObjectState('Há um problema de conexão com a API');
    }
  }

  @override
  void initState() {
    value = InitialObjectState<TokenModel?>(null);
  }
}
