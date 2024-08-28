import 'package:dio/dio.dart';

import '../../models/item_orcamento_model.dart';
import '../../models/token_model.dart';
import '../cache/cache_service.dart';
import '../data/api_service_response.dart';
import 'api_service.dart';

class ItemOrcamentoApiService extends ApiService {
  ItemOrcamentoApiService() : super(baseResourcePath: 'ItensOrcamento/');

  Future<ApiServiceResponse<ItemOrcamentoModel?>> postItemOrcamento(ItemOrcamentoModel itemOrcamento) async {
    ItemOrcamentoModel? itemModel;

    TokenModel? tokenInfo;
    var response401WithInvalidToken =
        ApiServiceResponse(response: null, statusCode: 401, isSuccessStatusCode: false, validToken: false);

    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.post(
        '${baseResourcePath}',
        data: itemOrcamento.toJson(),
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        itemModel = ItemOrcamentoModel.fromMap(response.data);
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
    return ApiServiceResponse(response: itemModel, statusCode: 201, isSuccessStatusCode: true, validToken: true);
  }

  Future<ApiServiceResponse<List<ItemOrcamentoModel>>> getItensOrcamento(int orcamentoId) async {
    List<ItemOrcamentoModel> itens = [];
    TokenModel? tokenInfo;

    var response401WithInvalidToken =
        ApiServiceResponse(response: itens, statusCode: 401, isSuccessStatusCode: false, validToken: false);

    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.get<List>(
        '${baseResourcePath}orcamento/$orcamentoId',
        options: Options(
          headers: putTokenInAuthorizationHeader(tokenInfo.accessToken),
        ),
      );

      if (response.data != null) {
        itens = response.data!.map((e) => ItemOrcamentoModel.fromMap(e)).toList();
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
    return ApiServiceResponse(response: itens, statusCode: 200, isSuccessStatusCode: true, validToken: true);
  }

  Future<ApiServiceResponse<bool>> deleteOrcamento(ItemOrcamentoModel itemOrcamento) async {
    bool deleted = false;
    TokenModel? tokenInfo;
    var response401WithInvalidToken =
        ApiServiceResponse(response: deleted, statusCode: 401, isSuccessStatusCode: false, validToken: false);
    try {
      tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return response401WithInvalidToken;
      }

      var response = await dio.delete(
        '${baseResourcePath}${itemOrcamento.id}',
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
}
