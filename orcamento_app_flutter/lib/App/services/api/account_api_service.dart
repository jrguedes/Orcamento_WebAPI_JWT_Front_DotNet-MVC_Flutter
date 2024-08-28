import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';
import 'package:orcamento_app_flutter/App/services/exceptions/not_found_exception.dart';

import '../../models/login_model.dart';
import '../../models/token_model.dart';
import '../cache/cache_service.dart';

class AccountApiService extends ApiService {
  AccountApiService() : super(baseResourcePath: 'Account/');

  Future<TokenModel?> _cachedSignIn() async {
    var jwtTokenInfo = await CacheService.getJWTTokenInfo();
    if (jwtTokenInfo != null && jwtTokenInfo.accessToken != '') {
      if (await validateToken(jwtTokenInfo.accessToken)) {
        return jwtTokenInfo;
      }
    }
    await logout();
    return null;
  }

  Future<TokenModel?> _signIn(LoginModel login) async {
    TokenModel? tokenModel;
    try {
      var response = await dio.post<Map<String, dynamic>>('${baseResourcePath}SignIn', data: login.toJson());

      if (response.data != null) {
        tokenModel = TokenModel.fromMap(response.data!);
        await CacheService.setJWTTokenInfo(tokenModel);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NotFoundException("Usuário ou senha inválidos!");
      }
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return tokenModel;
  }

  Future<TokenModel?> signIn(LoginModel login) async {
    TokenModel? jwtTokenInfo;
    jwtTokenInfo = await _cachedSignIn();

    if (jwtTokenInfo != null) {
      return jwtTokenInfo;
    }

    return _signIn(login);
  }

  Future<void> logout() async {
    try {
      await CacheService.clearCache();
    } catch (e) {
      rethrow;
    }
  }
}
