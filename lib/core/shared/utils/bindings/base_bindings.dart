import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../middleware/auth_guard.dart';
import '../../platform/gallery_info.dart';
import '../../platform/network_info.dart';
import '../../platform/share_info.dart';
import '../../usecase/open_album.dart';
import '../../usecase/open_image_camera.dart';
import '../../usecase/open_image_gallery.dart';
import '../../usecase/open_share.dart';
import '../../usecase/open_url.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<GalleryInfo>(() => GalleryInfoImpl(Get.find()))
      ..lazyPut<NetworkInfo>(() => NetworkInfoImpl())
      ..lazyPut(() => SharedPreferences.getInstance)
      ..lazyPut(() => OpenAlbumGallery(Get.find()))
      ..lazyPut(() => OpenImageGallery(Get.find()))
      ..lazyPut(() => OpenImageCamera(Get.find()))
      ..lazyPut<ShareInfo>(() => ShareInfoImpl())
      ..lazyPut(
        () => AuthGuard(
          authLocalDatabase: Get.find(),
          kycLocalDatabase: Get.find(),
        ),
        fenix: true,
      )
      ..lazyPut(() => OpenShare(Get.find()))
      ..lazyPut<HiveInterface>(() => Hive)
      ..lazyPut(() => OpenUrl(Get.find()))
      ..lazyPut(() => ImagePicker())
      ..lazyPut(GetHttpClient.new);
  }
}
