import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: key,
      height: height,
      width: width,
      memCacheWidth: 262,
      imageUrl: imageUrl!,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.red,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        size: 40,
        Iconsax.user,
        color: Colors.red,
      ),
    );
  }
}
