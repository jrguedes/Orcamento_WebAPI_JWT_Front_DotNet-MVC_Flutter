import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';
import 'package:orcamento_app_flutter/App/services/cache/cache_service.dart';

class OrcamentoApiService extends APIService {
  OrcamentoApiService() : super(baseResourcePath: 'Orcamentos/');

  Future<OrcamentoModel?> postOrcamento(OrcamentoModel orcamento) async {
    OrcamentoModel? orcamentoModel;
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return null;
      }
      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return orcamentoModel;
  }

  Future<bool> deleteOrcamento(OrcamentoModel orcamento) async {
    bool deleted = false;
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return false;
      }
      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return deleted;
  }

  Future<List<OrcamentoModel>> getOrcamentos() async {
    List<OrcamentoModel> orcamentos = [];
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return orcamentos;
      }

      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return orcamentos;
  }
}
