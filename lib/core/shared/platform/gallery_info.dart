import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../error/failures.dart';
import 'package:path/path.dart' as path;

/// Retrieve gallery of device
abstract class GalleryInfo {
  /// Gets a single image from camera
  Future<Either<Failure, String>> camera();

  /// Gets a single image from gallery
  Future<Either<Failure, String>> gallery();

  /// Gets multiple images from gallery
  Future<Either<Failure, List<String>>> album();

  /// Gets a video from gallery
  Future<Either<Failure, String>> video(bool useCamera);

  // /// Uploads an image to firebase storage and returns the image
  // Future<Either<Failure, String>> upload(String filePath, String? storagePath);

  // /// Uploads a video to firebase storage and returns the video
  // Future<Either<Failure, String>> uploadVideo(String filePath);

  /// Compress and resize image
  Future<Either<Failure, String>> compress(String filePath);

  /// Upload audio to firebase storage
  // Future<Either<Failure, String>> uploadAudio(String filePath, String studyId);

  /// Retrieves interview audio list from firebase storage
  // Future<Either<Failure, List<Interview>>> interviewAudios(String userId);
}

/// Implements [GalleryInfo]
class GalleryInfoImpl implements GalleryInfo {
  /// Constructor
  GalleryInfoImpl(this.picker);

  /// Image picker library to open gallery
  final ImagePicker picker;

  @override
  Future<Either<Failure, String>> camera() async {
    try {
      final file = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      if (file == null) {
        throw PlatformException(code: 'Invalid image path');
      }
      return Right(file.path);
    } on PlatformException {
      return const Left(Failure('Device failure.\nFailed to retrieve image.'));
    }
  }

  @override
  Future<Either<Failure, String>> compress(String filePath) async {
    try {
      final fileName = path.basename(filePath);
      final formatter = DateFormat('yyyyMMddHHmmss');
      final uniqueFileName = '${formatter.format(DateTime.now())}_$fileName';

      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/$uniqueFileName';

      final file = await FlutterImageCompress.compressAndGetFile(
        filePath,
        targetPath,
        quality: 88,
        minHeight: 1024,
        minWidth: 1024,
      );

      if (file == null) {
        throw PlatformException(code: 'Invalid image path');
      }

      return Right(file.path);
    } on Exception {
      return const Left(Failure('Device failure.\nFailed to retrieve image.'));
    }
  }

  @override
  Future<Either<Failure, String>> video(bool useCamera) async {
    try {
      final file = await picker.pickVideo(
        source: useCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (file == null) {
        throw PlatformException(code: 'Invalid image path');
      }
      return Right(file.path);
    } on PlatformException {
      return const Left(Failure('Device failure.\nFailed to retrieve image.'));
    }
  }

  // @override
  // Future<Either<Failure, String>> upload(
  //   String filePath,
  //   String? storagePath,
  // ) async {
  //   try {
  //     // Create a Reference to the file
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child(storagePath ?? 'images')
  //         .child(filePath.split('/').last);
  //     final metadata = SettableMetadata(
  //       contentType: 'image/*',
  //       customMetadata: {'picked-file-path': filePath},
  //     );
  //     final result = await ref.putFile(io.File(filePath), metadata);
  //     return Right(await result.ref.getDownloadURL());
  //   } on PlatformException {
  //     return const Left(Failure('Device failure.\nFailed to upload image.'));
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> uploadVideo(String filePath) async {
  //   try {
  //     // Create a Reference to the file
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('videos')
  //         .child(filePath.split('/').last);
  //     final metadata = SettableMetadata(
  //       contentType: 'video/*',
  //       customMetadata: {'picked-file-path': filePath},
  //     );
  //     final result = await ref.putFile(io.File(filePath), metadata);
  //     return Right(await result.ref.getDownloadURL());
  //   } on PlatformException {
  //     return const Left(Failure('Device failure.\nFailed to upload image.'));
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> uploadAudio(String filePath, String studyId) async {
  //   try {
  //     // Create a Reference to the file
  //     final ref = FirebaseStorage.instance.ref().child('interviews').child(studyId).child(filePath.split('/').last);
  //     final metadata = SettableMetadata(contentType: 'audio/*', customMetadata: {'picked-file-path': filePath});
  //     final result = await ref.putFile(io.File(filePath), metadata);
  //     return Right(await result.ref.getDownloadURL());
  //   } on PlatformException {
  //     return const Left(Failure('Device failure.\nFailed to upload image.'));
  //   }
  // }

  @override
  Future<Either<Failure, String>> gallery() async {
    try {
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      if (file == null) {
        throw PlatformException(code: 'Invalid image path');
      }
      return Right(file.path);
    } on PlatformException {
      return const Left(Failure('Device failure.\nFailed to retrieve image.'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> album() async {
    try {
      final files = await picker.pickMultiImage(
        imageQuality: 85,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      if (files.isEmpty) {
        throw PlatformException(code: 'Invalid image paths');
      }
      return Right(files.map((e) => e.path).toList());

      // final result = files
      //     .map((e) async => String.fromCharCodes(await e.readAsBytes()))
      //     .toList();
      // return Right(await Future.wait(result));
    } on PlatformException {
      return const Left(Failure('Device failure.\nFailed to retrieve image.'));
    }
  }

  // @override
  // Future<Either<Failure, List<Interview>>> interviewAudios(String userId) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref().child('interviews').child(userId);
  //     final result = await ref.listAll();
  //     if (result.items.isEmpty) {
  //       return const Right([]);
  //     }

  //     return Right(await Future.wait(result.items
  //         .map((e) async => Interview(
  //               responses: [],
  //               study: Study.initial(),
  //               name: e.name.split('.').first,
  //             ))
  //         .toList()));
  //   } on PlatformException {
  //     return const Left(Failure('Device failure.\nFailed to retrieve interviews.'));
  //   }
  // }
}
