import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/usecase/open_image_camera.dart';
import '../../../../core/usecase/open_image_gallery.dart';
import '../../../../core/usecase/usecase.dart';
import '../widgets/widgets.dart';

class KycController extends GetxController {
  final currentUser = User.empty().obs;
  final selfie = ValueNotifier<String>('').obs;
  final backImg = ValueNotifier<String>('').obs;
  final docsFormKey = GlobalKey<FormState>().obs;
  final frontImg = ValueNotifier<String>('').obs;
  static KycController get instance => Get.find();

  final dobController = TextEditingController().obs;
  final fnameController = TextEditingController().obs;
  final lnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final personalDetailsFormKey = GlobalKey<FormState>().obs;

  final OpenImageCamera openImageCamera;
  final OpenImageGallery openImageGallery;
  final RetrieveUserUsecase retrieveUserUsecase;

  KycController({
    required this.openImageCamera,
    required this.openImageGallery,
    required this.retrieveUserUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    retrieveUser();
    // Initialization logic here
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      emailController.value.text = success.email!;
      lnameController.value.text = success.lastname!;
      fnameController.value.text = success.firstname!;
      phoneController.value.text = success.phoneNumber!;
      update();
      return success;
    });
  }

  Future<void> validateDocs() async {
    if (docsFormKey.value.currentState!.validate()) {
      Get.toNamed(Routers.selfieInfo);
    }
  }

  Future<void> validateSelfie() async {
    if (docsFormKey.value.currentState!.validate()) {
      
      Get.offNamed(Routers.kycSuccess);
    }
  }

  Future<void> validateUserDetails() async {
    if (personalDetailsFormKey.value.currentState!.validate()) {
      Get.toNamed(Routers.docUpload);
    }
  }

  Future<String> openCamera() async {
    final result = await openImageCamera(NoParams());
    return result.fold((failure) => '', (success) => success);
  }

  Future<String> openGallery() async {
    final result = await openImageGallery(NoParams());
    return result.fold((failure) => '', (success) => success);
  }

  @override
  void onClose() {
    // Cleanup logic here
    super.onClose();
  }
}
