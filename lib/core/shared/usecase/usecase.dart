import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../data/result.dart';
import '../error/failures.dart';

/// Blue print for usecase
abstract class UseCase<T, Params> {
  /// Forward usecase classes to repositories
  Future<Either<Failure, T>> call(Params params);
}

abstract class DualUseCase<T, Params, Params2> {
  /// Forward usecase classes to repositories
  Future<Either<Failure, T>> call(Params params, Params2 params2);
}

abstract class APIUseCase<T, Params> {
  /// Forward usecase classes to repositories
  Future<Either<FailureResult, T>> call(Params params);
}

/// Used when usecase doesn't take any parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

/// Generic params for all objects
class ObjectParams<T> extends Equatable {
  /// Constructor
  const ObjectParams(this.value);

  ///  object class instance
  final T value;

  @override
  List<Object> get props => [value as Object];
}
