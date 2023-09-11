class ServerException implements Exception {}


class ApiException implements Exception {
  ApiException({required this.message});

  final String message;
}
