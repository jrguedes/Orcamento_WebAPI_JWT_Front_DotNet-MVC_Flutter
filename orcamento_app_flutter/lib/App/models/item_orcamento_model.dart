import 'dart:convert';

class ItemOrcamentoModel {
  final int id;
  final String estabelecimento;
  final String telefone;
  final String responsavel;
  final double valor;
  final String descricao;
  final int orcamentoId;

  ItemOrcamentoModel({
    required this.id,
    required this.estabelecimento,
    required this.telefone,
    required this.responsavel,
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
      estabelecimento: estabelecimento ?? this.estabelecimento,
      telefone: telefone ?? this.telefone,
      responsavel: responsavel ?? this.responsavel,
      valor: valor ?? this.valor,
      descricao: descricao ?? this.descricao,
      orcamentoId: orcamentoId ?? this.orcamentoId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'estabelecimento': estabelecimento});
    result.addAll({'telefone': telefone});
    result.addAll({'responsavel': responsavel});
    result.addAll({'valor': valor});
    result.addAll({'descricao': descricao});
    result.addAll({'orcamentoId': orcamentoId});

    return result;
  }

  factory ItemOrcamentoModel.fromMap(Map<String, dynamic> map) {
    return ItemOrcamentoModel(
      id: map['id']?.toInt() ?? 0,
      estabelecimento: map['estabelecimento'] ?? '',
      telefone: map['telefone'] ?? '',
      responsavel: map['responsavel'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      descricao: map['descricao'] ?? '',
      orcamentoId: map['orcamentoId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrcamentoModel.fromJson(String source) => ItemOrcamentoModel.fromMap(json.decode(source));
}
