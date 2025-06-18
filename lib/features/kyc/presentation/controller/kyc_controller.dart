import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/usecase/usecase.dart';
import '../widgets/widgets.dart';

class KycController extends GetxController {
  final currentUser = User.empty().obs;
  static KycController get instance => Get.find();

  final dobController = TextEditingController().obs;
  final fnameController = TextEditingController().obs;
  final lnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final personalDetailsFormKey = GlobalKey<FormState>().obs;

  final RetrieveUserUsecase retrieveUserUsecase;

  KycController({required this.retrieveUserUsecase});

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

  Future<void> validateUserDetails() async {
    if (personalDetailsFormKey.value.currentState!.validate()) {}
  }

  @override
  void onClose() {
    // Cleanup logic here
    super.onClose();
  }
}
