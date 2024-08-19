import 'package:dio/dio.dart';

import '../../models/item_orcamento_model.dart';
import '../cache/cache_service.dart';
import 'api_service.dart';

class ItemOrcamentoApiService extends APIService {
  ItemOrcamentoApiService() : super(baseResourcePath: 'ItensOrcamento/');

  Future<ItemOrcamentoModel?> postItemOrcamento(ItemOrcamentoModel itemOrcamento) async {
    ItemOrcamentoModel? itemModel;
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return null;
      }
      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return itemModel;
  }

  Future<List<ItemOrcamentoModel>> getItensOrcamento(int orcamentoId) async {
    List<ItemOrcamentoModel> itens = [];
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return itens;
      }

      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return itens;
  }

  Future<bool> deleteOrcamento(ItemOrcamentoModel itemOrcamento) async {
    bool deleted = false;
    try {
      var tokenInfo = await CacheService.getJWTTokenInfo();

      if (tokenInfo == null) {
        return false;
      }
      //fazer a verificação do token no ok do AccountController na API

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
      print('${e.response?.statusCode} with message ${e.response?.statusMessage}');
    } catch (e) {
      rethrow;
    }
    return deleted;
  }
}
