// ignore_for_file: file_names, always_use_package_imports

import 'package:game_app/controllers/home_page_controller.dart';
import 'package:game_app/controllers/show_all_account_controller.dart';
import 'package:game_app/controllers/tournament_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<ShowAllAccountsController>(() => ShowAllAccountsController());
    Get.lazyPut<TournamentController>(() => TournamentController());
  }
}
