import 'package:dio/dio.dart';

abstract class APIService {
  final dio = Dio();
  final String apiRootPath = 'https://localhost:7206/api/';
  late final String baseResourcePath;

  APIService({required String baseResourcePath}) {
    this.baseResourcePath = apiRootPath + baseResourcePath;
  }
}
