import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class APIService {
  @protected
  final dio = Dio();
  @protected
  final String apiRootPath = 'https://localhost:7206/api/';
  @protected
  late final String baseResourcePath;

  APIService({required String baseResourcePath}) {
    this.baseResourcePath = apiRootPath + baseResourcePath;
  }

  @protected
  Map<String, dynamic> putTokenInAuthorizationHeader(String accessToken) {
    return {'Authorization': 'Bearer $accessToken'};
  }
}
