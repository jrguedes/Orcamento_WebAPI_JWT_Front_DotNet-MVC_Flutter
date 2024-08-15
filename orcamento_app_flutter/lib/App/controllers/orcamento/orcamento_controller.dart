import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';

class OrcamentoController {
  final OrcamentoApiService service;
  OrcamentoModel? orcamentoModel;

  OrcamentoController(this.service);

/*
  final ValueNotifier<ObjectState<OrcamentoModel?>> orcamentoState =
      ValueNotifier<ObjectState<OrcamentoModel?>>(InitialObjectState(null));
*/

  Future<void> getOrcamentos() async {
    var orcamentos = await service.getOrcamentos();
    return;
  }

  Future<void> deleteOrcamento(OrcamentoModel orcamento) async {
    var deleted = await service.deleteOrcamento(orcamento);
    return;
  }

/*
  Future<void> saveOrcamento(String descricaoOrcamento) async {
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());

    orcamentoState.value = LoadingObjectState();
    try {
      var orcamentoResult = await _service.postOrcamento(orcamento);
      if (orcamentoResult == null) {
        orcamentoState.value = ErrorObjectState('Usuário ou senha inválidos!');
      } else {
        orcamentoState.value = SuccessObjectState<OrcamentoModel?>(orcamentoResult);
      }
    } catch (e) {
      orcamentoState.value = ErrorObjectState('Há um problema de conexão com a API');
    }
  }
  */

  Future<void> saveOrcamento(String descricaoOrcamento) async {
    orcamentoModel = null;
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    orcamentoModel = await service.postOrcamento(orcamento);
  }
}
