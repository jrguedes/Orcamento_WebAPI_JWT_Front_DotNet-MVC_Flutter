import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';

import '../../models/response_model.dart';

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

  Future<ResponseModel<OrcamentoModel?>> saveOrcamento(String descricaoOrcamento) async {
    var orcamentoSave = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    var saveResponse = await service.postOrcamento(orcamentoSave);
    var response = ResponseModel<OrcamentoModel?>(validToken: false, value: saveResponse.response);

    if (saveResponse.validToken) {
      response = response.copyWith(validToken: true);
    }

    return response;
  }

  Future<ResponseModel<OrcamentoModel?>> updateOrcamento(OrcamentoModel orcamento, String descricao) async {
    orcamento = orcamento.copyWith(descricao: descricao);

    var updateResponse = await service.updateOrcamento(orcamento);
    var response = ResponseModel<OrcamentoModel?>(validToken: false, value: updateResponse.response);

    if (updateResponse.validToken) {
      response = response.copyWith(validToken: true);
    }
    return response;
  }
}
