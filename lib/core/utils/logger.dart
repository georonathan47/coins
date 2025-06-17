import 'dart:async';
import 'dart:developer';

class TLoggerHelper {
  static void logEvent(
    dynamic message, {
    String? eventName,

    StackTrace? stackTrace,
  }) {
    log(
      message.toString(),
      time: DateTime.now(),
      zone: Zone.current,
      name: eventName ?? 'EVENT',
      stackTrace: stackTrace,
    );
  }

  static void logRefreshAttempt(
    dynamic message, {
    required int statusCode,
    StackTrace? stackTrace,
  }) {
    log(
      '$message failed with status code: $statusCode, attempting token refresh',
      time: DateTime.now(),
      zone: Zone.current,
      name: 'Token Refresh Attempt',
      stackTrace: stackTrace,
    );
  }

  static void logApiResult({
    required int code,
    required String method,
    required String message,
    required String httpMethod,
  }) {
    String getEmoji(int code) {
      switch (code) {
        case >= 200 && < 300:
          return '✅';
        case >= 400 && < 500:
          return '❌';
        case >= 500:
          return '🚫';
        default:
          return '✅';
      }
    }

    int getLevel(int code) {
      switch (code) {
        case >= 200 && < 300:
          return 200;
        case >= 400 && < 500:
          return 500;
        case >= 500:
          return 900;
        default:
          return 0;
      }
    }

    log(
      '[${getEmoji(code)} $httpMethod - $code ${getEmoji(code)}] - ($method): $message - ${DateTime.now()}',
      name: 'API',
      zone: Zone.current,
      time: DateTime.now(),
      level: getLevel(code),
      stackTrace: code >= 400 ? StackTrace.current : null,
    );
  }
}
