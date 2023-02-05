import 'package:get/get.dart';

import '../controllers/tournaments_controller.dart';

class TournamentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TournamentsController>(
      () => TournamentsController(),
    );
  }
}
