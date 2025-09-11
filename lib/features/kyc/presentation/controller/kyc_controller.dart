import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/shared/usecase/open_image_camera.dart';
import '../../../../core/shared/usecase/open_image_gallery.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../domain/entities/kyc_entity.dart';
import '../../domain/entities/kyc_status.enum.dart';
import '../../domain/usecases/check_status_usecase.dart';
import '../../domain/usecases/initiate_kyc_usecase.dart';
import '../widgets/widgets.dart';

class KycController extends GetxController {
  final statusResult = false.obs;
  final currentUser = User.empty().obs;
  final kycRequest = KycModel.empty().obs;
  final selectedGender = Gender.male.obs;
  final selfie = ValueNotifier<String>('').obs;
  final backImg = ValueNotifier<String>('').obs;
  final docsFormKey = GlobalKey<FormState>().obs;
  final frontImg = ValueNotifier<String>('').obs;
  static KycController get instance => Get.find();

  final dobController = TextEditingController().obs;
  final issController = TextEditingController().obs;
  final expController = TextEditingController().obs;
  final fnameController = TextEditingController().obs;
  final lnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final personalDetailsFormKey = GlobalKey<FormState>().obs;

  final OpenImageCamera openImageCamera;
  final OpenImageGallery openImageGallery;
  final InitiateKycUsecase initiateKycUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final CheckKycStatusUsecase checkKycStatusUsecase;

  KycController({
    required this.openImageCamera,
    required this.openImageGallery,
    required this.initiateKycUsecase,
    required this.retrieveUserUsecase,
    required this.checkKycStatusUsecase,
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
      emailController.value.text = success.email ?? '';
      lnameController.value.text = success.lastname ?? '';
      fnameController.value.text = success.firstname ?? '';
      phoneController.value.text = success.phoneNumber ?? '';
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
      showDialog(
        context: Get.context!,
        builder: (ctx) => const Center(child: CircularProgressIndicator()),
      );
      final request = kycRequest.value.copyWith(
        documentId: 'PASSPORT',
        documentType: 'PASSPORT',
        dob: dobController.value.text,
        selfieFile: selfie.value.value,
        backIdFile: backImg.value.value,
        frontIdFile: frontImg.value.value,
        userSId: currentUser.value.userId,
        email: emailController.value.text,
        gender: selectedGender.value.value,
        issueDate: issController.value.text,
        expiryDate: expController.value.text,
        lastname: lnameController.value.text,
        firstname: fnameController.value.text,
        phoneNumber: phoneController.value.text,
      );
      final result = await initiateKycUsecase(ObjectParams(request));
      Get.back();
      return result.fold(
        (failure) {
          THelperFunctions.showSnackBar(
            title: 'Error',
            message: failure.message,
            bgColor: TColors.error,
          );
        },
        (success) {
          THelperFunctions.showSnackBar(
            title: 'Success',
            message: success,
            bgColor: TColors.success,
          );
          Get.offAllNamed(Routers.index);
        },
      );
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

  Future<KycStatus> checkStatus() async {
    final result = await checkKycStatusUsecase(NoParams());
    return result.fold((failure) => KycStatus.rejected, (success) {
      if (success == KycStatus.approved) {
        statusResult.value = true;
        return success;
      } else if (success == KycStatus.pending) {
        showAdaptiveDialog(
          context: Get.context!,
          builder: (ctx) {
            return AlertDialog(
              title: Text('KYC Under Review'),
              content: Text(
                'Your KYC verification is under review. It will take the team 3-5 business days to review your application. You will receive an email once your application is approved or rejected.',
              ),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('OK')),
              ],
            );
          },
        );
        return success;
      } else {
        statusResult.value = false;
        return success;
      }
    });
  }

  Future<KycStatus> checkSidebarStatus() async {
    final result = await checkKycStatusUsecase(NoParams());
    return result.fold((failure) => KycStatus.rejected, (success) => success);
  }

  @override
  void onClose() {
    // Cleanup logic here
    super.onClose();
  }
}
