import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:share_plus/share_plus.dart';

import '../error/failures.dart';

/// Share info to other apps on device
abstract class ShareInfo {
  /// opens share bottom sheet on device
  Future<Either<Failure, bool>> share(String text);
}

/// Implements [ShareInfo]
class ShareInfoImpl implements ShareInfo {
  @override
  Future<Either<Failure, bool>> share(String text) async {
    try {
      await Share.share(text);
      return const Right(true);
    } on PlatformException {
      return const Left(
        Failure(
          "Device failure🔔.\nYour device doesn't support this action.",
        ),
      );
    }
  }
}
