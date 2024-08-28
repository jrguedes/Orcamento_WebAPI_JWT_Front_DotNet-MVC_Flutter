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
    var deleteResponse = await service.deleteOrcamento(orcamento);

    if (!deleteResponse.validToken) {
      //remover pages privadas e mandar pra tela de login
    }

    return deleteResponse.response;
  }

  Future<OrcamentoModel?> saveOrcamento(String descricaoOrcamento) async {
    var orcamentoSave = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    var saveResponse = await service.postOrcamento(orcamentoSave);

    if (!saveResponse.validToken) {
      //remover pages privadas e mandar pra tela de login
    }

    return saveResponse.response;
  }

  Future<void> updateOrcamento(OrcamentoModel orcamento, String descricao) async {
    orcamento = orcamento.copyWith(descricao: descricao);

    var updateResponse = await service.updateOrcamento(orcamento);

    if (!updateResponse.validToken) {
      //remover pages privadas e mandar pra tela de login
    }
  }
}
