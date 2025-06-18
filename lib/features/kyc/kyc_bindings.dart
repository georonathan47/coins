import 'package:get/get.dart';

class KycBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => KycController(retrieveUserUsecase: Get.find()));
  }
}
