import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../platform/gallery_info.dart';
import 'usecase.dart';

/// Open Gallery for a multiple images
class OpenAlbumGallery implements UseCase<List<String>, NoParams> {
  /// Constructor
  OpenAlbumGallery(this.repository);

  /// Repository
  final GalleryInfo repository;

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) => repository.album();
}
