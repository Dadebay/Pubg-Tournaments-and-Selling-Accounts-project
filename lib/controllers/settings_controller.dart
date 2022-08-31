// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../models/index_model.dart';

class SettingsController extends GetxController {
  final storage = GetStorage();
  RxBool agreeButton = false.obs;
  RxBool loginUser = false.obs;
  RxInt bannerSelectedIndex = 0.obs;
  RxString pubgType = "".obs;
  RxString locationName = "".obs;
  late Future<List<UcModel>> getData;
  RxString userMoney = "".obs;
  @override
  void onInit() {
    super.onInit();
    getData = UcModel().getUCS();
    getMeSatus();
    changeUserUI();
  }

  getMeSatus() async {
    final token = await Auth().getToken();
    if (token!.isNotEmpty) {
      AccountByIdModel().getMe().then((value) {
        userMoney.value = value.points.toString();
      });
    }
  }

  changeUserUI() async {
    final token = await Auth().getToken();
    if (token != null) {
      loginUser.value = true;
    } else {
      loginUser.value = false;
    }
  }

  var tm = const Locale(
    'tr',
  );
  var ru = const Locale(
    'ru',
  );
  var en = const Locale(
    'en',
  );

  switchLang(String value) {
    if (value == "en") {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == "ru") {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tr');
    }
    update();
  }
}
