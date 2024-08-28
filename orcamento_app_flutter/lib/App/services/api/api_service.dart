import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ApiService {
  @protected
  final dio = Dio();
  @protected
  final String apiRootPath = 'https://localhost:7206/api/';
  @protected
  late final String baseResourcePath;

  ApiService({required String baseResourcePath}) {
    this.baseResourcePath = apiRootPath + baseResourcePath;
  }

  @protected
  Future<bool> validateToken(String token) async {
    bool tokenIsValid = false;
    try {
      var response = await dio.get<bool>(
        '${apiRootPath}Account/Token/',
        options: Options(
          headers: putTokenInAuthorizationHeader(token),
        ),
      );

      if (response.data != null) {
        tokenIsValid = response.data as bool;
        return tokenIsValid;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        tokenIsValid = false;
      }
    } catch (e) {
      tokenIsValid = false;
    }
    return tokenIsValid;
  }

  @protected
  Map<String, dynamic> putTokenInAuthorizationHeader(String accessToken) {
    return {'Authorization': 'Bearer $accessToken'};
  }
}
