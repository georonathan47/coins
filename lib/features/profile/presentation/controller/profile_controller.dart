
import '../../../../core/shared/constants/text_strings.dart';
import '../widgets/widgets.dart';

class ProfileController extends GetxController {
  final OpenShare openShareUsecase;
  final OpenImageCamera openImageCamera;
  final OpenImageGallery openImageGallery;
  static ProfileController get instance => Get.find();



  ProfileController({
    required this.openShareUsecase,
    required this.openImageCamera,
    required this.openImageGallery,
  });

  Future<String> openCamera() async {
    final result = await openImageCamera(NoParams());
    return result.fold((failure) => '', (success) => success);
  }

  Future<String> openGallery() async {
    final result = await openImageGallery(NoParams());
    return result.fold((failure) => '', (success) => success);
  }

  Future<void> share() async {
    await openShareUsecase(ObjectParams(TTexts.shareText));
  }
}
