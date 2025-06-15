// import 'package:equatable/equatable.dart';
// import 'package:fpdart/fpdart.dart';

// import '../error/failures.dart';
// import '../platform/gallery_info.dart';
// import 'usecase.dart';

// /// [UploadFirebaseImage] usecase
// class UploadFirebaseImage
//     implements UseCase<String, UploadFirebaseImageParams> {
//   /// Constructor
//   UploadFirebaseImage(this.repository);

//   /// Repository
//   final GalleryInfo repository;

//   @override
//   Future<Either<Failure, String>> call(UploadFirebaseImageParams params) =>
//       repository.upload(
//         params.filePath,
//         params.storagePath,
//       );
// }

// /// [UploadFirebaseImageParams] params
// class UploadFirebaseImageParams extends Equatable {
//   /// Constructor
//   const UploadFirebaseImageParams(this.filePath, {this.storagePath = ''});

//   /// File path
//   final String filePath;

//   /// Storage path
//   final String? storagePath;

//   @override
//   List<Object?> get props => [filePath, storagePath];
// }
