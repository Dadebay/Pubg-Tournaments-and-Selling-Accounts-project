// ignore_for_file: file_names, always_use_package_imports

import 'package:get/get.dart';

import 'SettingsController.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
