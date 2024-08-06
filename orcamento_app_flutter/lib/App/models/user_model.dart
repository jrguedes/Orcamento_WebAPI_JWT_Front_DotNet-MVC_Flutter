import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String descricao;
  final String email;
  final String password;
  final String role;
  UserModel({
    required this.id,
    required this.name,
    required this.descricao,
    required this.email,
    required this.password,
    required this.role,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? descricao,
    String? email,
    String? password,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      descricao: descricao ?? this.descricao,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'descricao': descricao});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'role': role});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      descricao: map['descricao'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
