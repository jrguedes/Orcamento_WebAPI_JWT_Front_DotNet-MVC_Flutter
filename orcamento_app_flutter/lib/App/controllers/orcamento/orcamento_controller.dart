import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';
import 'package:orcamento_app_flutter/App/states/orcamentos_state.dart';

class OrcamentoController {
  final OrcamentosState orcamentosState = OrcamentosState();
  final OrcamentoAPIService _service = OrcamentoAPIService();

  Future<void> getOrcamentos() async {
    var orcamentos = await _service.getOrcamentos();
    return;
  }
}
