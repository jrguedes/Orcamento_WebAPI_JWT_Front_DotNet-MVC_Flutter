import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';

class OrcamentoService {
  Future<List<OrcamentoModel>> getOrcamentos() async {
    var orcamentos = List<OrcamentoModel>.generate(
      5,
      (id) => OrcamentoModel(id: id, descricao: 'Descricao $id', data: DateTime.now()),
    );
    await Future.delayed(const Duration(seconds: 1));
    return orcamentos;
  }
}
