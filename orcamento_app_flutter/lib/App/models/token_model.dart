import 'dart:convert';

class TokenModel {
  final bool authenticated;
  final DateTime created;
  final DateTime expirationDate;
  final String accessToken;
  final String userName;
  final String name;
  final String message;
  final String role;

  TokenModel({
    required this.authenticated,
    required this.created,
    required this.expirationDate,
    required this.accessToken,
    required this.userName,
    required this.name,
    required this.message,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'authenticated': authenticated});
    result.addAll({'created': created.toIso8601String()});
    result.addAll({'expirationDate': expirationDate.toIso8601String()});
    result.addAll({'accessToken': accessToken});
    result.addAll({'userName': userName});
    result.addAll({'name': name});
    result.addAll({'message': message});
    result.addAll({'role': role});

    return result;
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      authenticated: map['authenticated'] ?? false,
      created: DateTime.parse(map['created']),
      expirationDate: DateTime.parse(map['expirationDate']),
      accessToken: map['accessToken'] ?? '',
      userName: map['userName'] ?? '',
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source));
}
