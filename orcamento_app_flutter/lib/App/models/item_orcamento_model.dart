import 'dart:convert';

class ItemOrcamentoModel {
  final int id;
  final String local;
  final String telefone;
  final String responsavelOrcamento;
  final double valor;
  final String descricao;
  final int orcamentoId;

  ItemOrcamentoModel({
    required this.id,
    required this.local,
    required this.telefone,
    required this.responsavelOrcamento,
    required this.valor,
    required this.descricao,
    required this.orcamentoId,
  });

  ItemOrcamentoModel copyWith({
    int? id,
    String? estabelecimento,
    String? telefone,
    String? responsavel,
    double? valor,
    String? descricao,
    int? orcamentoId,
  }) {
    return ItemOrcamentoModel(
      id: id ?? this.id,
      local: estabelecimento ?? this.local,
      telefone: telefone ?? this.telefone,
      responsavelOrcamento: responsavel ?? this.responsavelOrcamento,
      valor: valor ?? this.valor,
      descricao: descricao ?? this.descricao,
      orcamentoId: orcamentoId ?? this.orcamentoId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'local': local});
    result.addAll({'telefone': telefone});
    result.addAll({'responsavelOrcamento': responsavelOrcamento});
    result.addAll({'valor': valor});
    result.addAll({'descricao': descricao});
    result.addAll({'orcamentoId': orcamentoId});

    return result;
  }

  factory ItemOrcamentoModel.fromMap(Map<String, dynamic> map) {
    return ItemOrcamentoModel(
      id: map['id']?.toInt() ?? 0,
      local: map['local'] ?? '',
      telefone: map['telefone'] ?? '',
      responsavelOrcamento: map['responsavelOrcamento'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      descricao: map['descricao'] ?? '',
      orcamentoId: map['orcamentoId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrcamentoModel.fromJson(String source) => ItemOrcamentoModel.fromMap(json.decode(source));
}
