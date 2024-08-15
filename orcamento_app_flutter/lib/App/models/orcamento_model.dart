import 'dart:convert';

class OrcamentoModel {
  final int id;
  final String descricao;
  final DateTime data;
  bool isExpanded = false;

  OrcamentoModel({required this.id, required this.descricao, required this.data});

  OrcamentoModel copyWith({
    int? id,
    String? descricao,
    DateTime? data,
  }) {
    return OrcamentoModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'descricao': descricao});
    result.addAll({'data': data.toIso8601String()});

    return result;
  }

  factory OrcamentoModel.fromMap(Map<String, dynamic> map) {
    return OrcamentoModel(
      id: map['id']?.toInt() ?? 0,
      descricao: map['descricao'] ?? '',
      data: DateTime.parse(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrcamentoModel.fromJson(String source) => OrcamentoModel.fromMap(json.decode(source));
}
