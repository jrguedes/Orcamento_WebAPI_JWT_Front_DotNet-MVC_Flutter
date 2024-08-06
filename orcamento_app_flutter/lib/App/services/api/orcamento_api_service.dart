import 'package:dio/dio.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/models/user_model.dart';

class OrcamentoAPIService {
  final _dio = Dio();

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
      var response = await _dio.get<List>('https://localhost:7206/api/Account');

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
