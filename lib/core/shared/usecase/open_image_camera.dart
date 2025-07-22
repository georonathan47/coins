import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../platform/gallery_info.dart';
import 'usecase.dart';

/// Open Camera for a single image
class OpenImageCamera implements UseCase<String, NoParams> {
  /// Constructor
  OpenImageCamera(this.repository);

  /// Repository
  final GalleryInfo repository;

  @override
  Future<Either<Failure, String>> call(NoParams params) => repository.camera();
}
