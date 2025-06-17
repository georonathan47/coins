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
      name: eventName ?? 'EVENT',
      time: DateTime.now(),
      stackTrace: stackTrace ?? StackTrace.current,
      zone: Zone.current,
    );
  }

  static void logApiResult({int? code, String? message}) {
    String getEmoji(int? code) {
      switch (code) {
        case null:
          return '🚫';
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

    int getLevel(int? code) {
      switch (code) {
        case null:
          return 5;
        case >= 200 && < 300:
          return 0;
        case >= 400 && < 500:
          return 2;
        case >= 500:
          return 3;
        default:
          return 0;
      }
    }

    log(
      '${getEmoji(code)} $code ${getEmoji(code)}: $message - ${DateTime.now()}',
      name: 'API',
      zone: Zone.current,
      time: DateTime.now(),
      level: getLevel(code),
      stackTrace: code! >= 400 ? StackTrace.current : null,
    );
  }
}
