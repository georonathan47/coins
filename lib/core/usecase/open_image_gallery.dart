import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../platform/gallery_info.dart';
import 'usecase.dart';

/// Pick an image from gallery
class OpenImageGallery implements UseCase<String, NoParams> {
  /// Constructor
  OpenImageGallery(this.repository);

  /// Repository
  final GalleryInfo repository;

  @override
  Future<Either<Failure, String>> call(NoParams params) => repository.gallery();
}
