import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';

class OrcamentoAPIService {
  Future<List<OrcamentoModel>> getOrcamentos() async {
    var orcamentos = List<OrcamentoModel>.generate(
      10,
      (id) => OrcamentoModel(id: id, descricao: 'Descrição orçamento $id', data: DateTime.now()),
    );
    await Future.delayed(const Duration(seconds: 1));
    return orcamentos;
  }
}
