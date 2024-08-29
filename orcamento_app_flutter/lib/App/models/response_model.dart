class ResponseModel<T> {
  final bool validToken;
  final T value;

  ResponseModel({required this.validToken, required this.value});

  ResponseModel<T> copyWith({
    bool? validToken,
    T? value,
  }) {
    return ResponseModel<T>(
      validToken: validToken ?? this.validToken,
      value: value ?? this.value,
    );
  }
}
