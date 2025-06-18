import 'dart:convert';

import 'package:flutter/material.dart'
    show
        BoxFit,
        BuildContext,
        FilterQuality,
        Icon,
        Image,
        Widget,
        precacheImage;
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../error/exception.dart';

Future<Widget> getImageWidget(
  String base64Image, {
  required BuildContext context,
  double? radius,
}) async {
  try {
    final decodedBytes = base64Decode(base64Image);
    final image = Image.memory(
      decodedBytes,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Iconsax.user, size: 65, color: TColors.accent);
      },
    );
    await precacheImage(image.image, context);
    return image;
  } catch (e) {
    return const Icon(Iconsax.user);
  }
}

Future<Widget> getImageString(
  String base64Image, {
  required BuildContext context,
}) async {
  try {
    final decodedBytes = base64Decode(base64Image);
    final image = Image.memory(
      decodedBytes,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Iconsax.user, size: 65, color: TColors.accent);
      },
    );
    await precacheImage(image.image, context);
    return image;
  } catch (e) {
    throw DeviceException(
      e.toString(),
    ); // Return an empty container in case of any error
  }
}
