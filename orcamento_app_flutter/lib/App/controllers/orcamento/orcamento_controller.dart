import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';
import 'package:orcamento_app_flutter/App/states/orcamentos_state.dart';

class OrcamentoController {
  final OrcamentosState orcamentosState = OrcamentosState();
  final OrcamentoAPIService _service = OrcamentoAPIService();

  Future<void> getOrcamentos() async {
    var orcamentos = await _service.getOrcamentos();
    return;
  }

  Future<void> saveOrcamento(String descricaoOrcamento) async {
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    var orcamentoResult = await _service.postOrcamento(orcamento);
  }
}
