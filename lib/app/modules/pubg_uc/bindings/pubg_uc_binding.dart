import 'package:get/get.dart';

import '../controllers/pubg_uc_controller.dart';

class PubgUcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PubgUcController>(
      () => PubgUcController(),
    );
  }
}
