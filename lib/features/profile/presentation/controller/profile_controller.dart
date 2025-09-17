import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/shared/constants/text_strings.dart';
import '../widgets/widgets.dart';

class ProfileController extends GetxController {
  final OpenShare openShareUsecase;
  final OpenImageCamera openImageCamera;
  final OpenImageGallery openImageGallery;
  final RetrieveUserUsecase retrieveUserUsecase;
  static ProfileController get instance => Get.find();

  final currentUser = User.empty().obs;
  final editKey = GlobalKey<FormState>().obs;
  final dobController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final confirmController = TextEditingController().obs;
  final lastnameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final firstnameController = TextEditingController().obs;

  ProfileController({
    required this.openShareUsecase,
    required this.openImageCamera,
    required this.openImageGallery,
    required this.retrieveUserUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    retrieveUser();
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      emailController.value.text = success.email ?? '';
      lastnameController.value.text = success.lastname ?? '';
      firstnameController.value.text = success.firstname ?? '';
      phoneController.value.text = success.phoneNumber ?? '';
      update();
      return success;
    });
  }

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
