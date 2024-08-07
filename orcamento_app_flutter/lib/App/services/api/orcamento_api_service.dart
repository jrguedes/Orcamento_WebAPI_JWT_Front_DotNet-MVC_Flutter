import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/models/user_model.dart';
import 'package:orcamento_app_flutter/App/services/api/api_service.dart';

class OrcamentoAPIService extends APIService {
  OrcamentoAPIService() : super(baseResourcePath: 'Account/');

  Future<List<OrcamentoModel>> getOrcamentos() async {
    var orcamentos = List<OrcamentoModel>.generate(
      10,
      (id) => OrcamentoModel(id: id, descricao: 'Descrição orçamento $id', data: DateTime.now()),
    );
    await Future.delayed(const Duration(seconds: 1));
    return orcamentos;
  }

  Future<List<UserModel>> getAccounts() async {
    List<UserModel> users = [];
    try {
      var response = await dio.get<List>('${apiRootPath}${baseResourcePath}');

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
}
