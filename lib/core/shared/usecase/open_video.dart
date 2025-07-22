import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';
import '../platform/gallery_info.dart';
import 'usecase.dart';

/// Picks video from gallery or camera
class OpenVideo implements UseCase<String, ObjectParams<bool>> {
  /// Constructor
  OpenVideo(this.repository);

  /// Repository
  final GalleryInfo repository;

  @override
  Future<Either<Failure, String>> call(ObjectParams<bool> params) =>
      repository.video(params.value);
}
