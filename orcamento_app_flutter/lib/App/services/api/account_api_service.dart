import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';

import '../../models/login_model.dart';
import '../../models/token_model.dart';
import '../cache/cache_service.dart';

class AccountApiService extends APIService {
  AccountApiService() : super(baseResourcePath: 'Account/');

  Future<TokenModel?> signIn(LoginModel login) async {
    TokenModel? tokenModel;
    try {
      var response = await dio.post<Map<String, dynamic>>('${baseResourcePath}SignIn', data: login.toJson());

      if (response.data != null) {
        tokenModel = TokenModel.fromMap(response.data!);
        await CacheService.setJWTTokenInfo(tokenModel);
      }
    } on DioException catch (e) {
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return tokenModel;
  }

  Future<void> logout() async {
    try {
      await CacheService.clearCache();
    } catch (e) {
      rethrow;
    }
  }
}
