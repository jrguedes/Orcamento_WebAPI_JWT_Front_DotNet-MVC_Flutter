import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';

class OrcamentoController {
  final OrcamentoApiService service;
  OrcamentoController(this.service);

  Future<void> getOrcamentos() async {
    await service.getOrcamentos();
    return;
  }

  Future<bool> deleteOrcamento(OrcamentoModel orcamento) async {
    var deleted = await service.deleteOrcamento(orcamento);
    return deleted;
  }

  Future<OrcamentoModel?> saveOrcamento(String descricaoOrcamento) async {
    var orcamentoSave = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    var orcamentoResponse = await service.postOrcamento(orcamentoSave);
    return orcamentoResponse;
  }

  Future<void> updateOrcamento(OrcamentoModel orcamento, String descricao) async {
    orcamento = orcamento.copyWith(descricao: descricao);

    await service.updateOrcamento(orcamento);
  }
}
