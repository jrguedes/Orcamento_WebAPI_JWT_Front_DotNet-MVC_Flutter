import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';
import 'package:orcamento_app_flutter/App/services/cache/cache_service.dart';

import '../data/api_service_response.dart';
import '../exceptions/not_found_exception.dart';

class OrcamentoApiService extends ApiService {
  OrcamentoApiService() : super(baseResourcePath: 'Orcamentos/');

  Future<ApiServiceResponse<OrcamentoModel?>> postOrcamento(OrcamentoModel orcamento) async {
    var response401WithInvalidToken =
        ApiServiceResponse(response: null, statusCode: 401, isSuccessStatusCode: false, validToken: false);
    OrcamentoModel? orcamentoModel;
    TokenModel? tokenInfo;
    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.post(
        '${baseResourcePath}',
        data: orcamento.toJson(),
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        orcamentoModel = OrcamentoModel.fromMap(response.data);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (!await validateToken(tokenInfo?.accessToken ?? 'invalidToken')) {
          return response401WithInvalidToken;
        }
      }
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return ApiServiceResponse(response: orcamentoModel, statusCode: 201, isSuccessStatusCode: true, validToken: true);
  }

  Future<ApiServiceResponse<bool>> deleteOrcamento(OrcamentoModel orcamento) async {
    TokenModel? tokenInfo;
    bool deleted = false;
    var response401WithInvalidToken =
        ApiServiceResponse(response: deleted, statusCode: 401, isSuccessStatusCode: false, validToken: false);
    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.delete(
        '${baseResourcePath}${orcamento.id}',
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        deleted = response.data as bool;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (!await validateToken(tokenInfo?.accessToken ?? 'invalidToken')) {
          return response401WithInvalidToken;
        }
      }
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return ApiServiceResponse(response: deleted, statusCode: 200, isSuccessStatusCode: true, validToken: true);
  }

  Future<ApiServiceResponse<List<OrcamentoModel>>> getOrcamentos() async {
    TokenModel? tokenInfo;
    List<OrcamentoModel> orcamentos = [];

    var response401WithInvalidToken =
        ApiServiceResponse(response: orcamentos, statusCode: 401, isSuccessStatusCode: false, validToken: false);

    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.get<List>(
        '${baseResourcePath}',
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        orcamentos = response.data!.map((e) => OrcamentoModel.fromMap(e)).toList();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (!await validateToken(tokenInfo?.accessToken ?? 'invalidToken')) {
          return response401WithInvalidToken;
        }
      }
      if (e.response?.statusCode == 404) {
        throw NotFoundException('Que pena! \n\n Não há orçamentos cadastrados');
      }
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return ApiServiceResponse(response: orcamentos, statusCode: 200, isSuccessStatusCode: true, validToken: true);
  }

  Future<ApiServiceResponse<OrcamentoModel?>> updateOrcamento(OrcamentoModel orcamento) async {
    OrcamentoModel? orcamentoModel;
    TokenModel? tokenInfo;
    var response401WithInvalidToken =
        ApiServiceResponse(response: null, statusCode: 401, isSuccessStatusCode: false, validToken: false);
    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.put(
        '${baseResourcePath}',
        data: orcamento.toJson(),
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        orcamentoModel = OrcamentoModel.fromMap(response.data);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (!await validateToken(tokenInfo?.accessToken ?? 'invalidToken')) {
          return response401WithInvalidToken;
        }
      }

      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return ApiServiceResponse(response: orcamentoModel, statusCode: 200, isSuccessStatusCode: true, validToken: true);
  }
}
