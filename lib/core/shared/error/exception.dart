/// [Exception] thrown for server related errors and device errors
class DeviceException implements Exception {
  /// Constructor for exceptions
  DeviceException(this.message, {this.statusCode = 404});

  /// Convert error messages from api
  factory DeviceException.fromJson(
    Map<String, dynamic> json, {
    int code = 404,
  }) => DeviceException(json['detail'] as String, statusCode: code);

  /// Error message
  final String message;

  /// Error code
  final int statusCode;

  @override
  String toString() => message;
}

class CacheException implements Exception {}

class ServerException implements Exception {}

class NoResultException implements Exception {
  NoResultException(this.message);
  final String message;
}

class BadRequestException implements Exception {
  BadRequestException(this.message);
  final String message;
}

class NoInternetException implements Exception {
  NoInternetException(this.message);
  final String message;
}
