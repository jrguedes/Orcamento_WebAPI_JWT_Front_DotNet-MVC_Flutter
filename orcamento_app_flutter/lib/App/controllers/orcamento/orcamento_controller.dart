import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';

class OrcamentoController {
  final OrcamentoApiService service;
  OrcamentoModel? orcamentoModel;

  OrcamentoController(this.service);

  Future<void> getOrcamentos() async {
    var orcamentos = await service.getOrcamentos();
    return;
  }

  Future<void> deleteOrcamento(OrcamentoModel orcamento) async {
    var deleted = await service.deleteOrcamento(orcamento);
    return;
  }

  Future<OrcamentoModel?> saveOrcamento(String descricaoOrcamento) async {
    orcamentoModel = null;
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    orcamentoModel = await service.postOrcamento(orcamento);
    return orcamentoModel;
  }

  Future<void> updateOrcamento(OrcamentoModel orcamento, String descricao) async {
    orcamento = orcamento.copyWith(descricao: descricao);

    await service.updateOrcamento(orcamento);
  }
}
