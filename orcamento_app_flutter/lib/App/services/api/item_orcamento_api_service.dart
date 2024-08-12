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
}
