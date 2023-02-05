import 'package:get/get.dart';

import '../controllers/best_players_controller.dart';

class BestPlayersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BestPlayersController>(
      () => BestPlayersController(),
    );
  }
}
