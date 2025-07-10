import 'package:equatable/equatable.dart';

class Result<T> extends Equatable {
  final String message;
  final int statusCode;
  final T? data;

  const Result({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  @override
  List<Object?> get props => [message, statusCode, data];
}

class SuccessResult<T> extends Result<T> {
  const SuccessResult({
    required super.message,
    required super.statusCode,
    required super.data,
  });
}

class FailureResult<T> extends Result<T> {
  const FailureResult({
    required super.message,
    required super.statusCode,
    required super.data,
  });
}
