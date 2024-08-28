class ApiServiceResponse<T> {
  final int statusCode;
  final bool isSuccessStatusCode;
  final bool validToken;
  final T response;
  ApiServiceResponse({
    required this.response,
    required this.statusCode,
    required this.isSuccessStatusCode,
    required this.validToken,
  });
}
