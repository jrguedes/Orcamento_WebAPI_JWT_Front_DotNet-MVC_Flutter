import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';

import '../../models/login_model.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';

class AccountAPIService extends APIService {
  AccountAPIService() : super(baseResourcePath: 'Account/');

  Future<List<UserModel>> getAccounts() async {
    List<UserModel> users = [];
    try {
      var response = await dio.get<List>('${baseResourcePath}');

      if (response.data != null) {
        users = response.data!.map((e) => UserModel.fromMap(e)).toList();
      }
    } on DioException catch (e) {
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return users;
  }

  Future<TokenModel?> signIn(LoginModel login) async {
    try {
      var response = await dio.post<Map<String, dynamic>>('${baseResourcePath}SignIn', data: login.toJson());

      if (response.data != null) {
        var tokenModel = TokenModel.fromMap(response.data!);
      }
    } on DioException catch (e) {
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
