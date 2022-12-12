// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final storage = GetStorage();
  RxBool agreeButton = false.obs;
  RxBool loginUser = false.obs;
  RxInt bannerSelectedIndex = 0.obs;
  RxString pubgType = ''.obs;
  RxString locationName = ''.obs;
  List<Map<String, dynamic>> notificationsList = [];

  dynamic addNotification({required String title, required String body}) async {
    notificationsList.add({'title': title, 'body': body});
    final String jsonString = jsonEncode(notificationsList);
    await storage.write('notificationList', jsonString);
  }

  dynamic returnNotifList() async {
    final result = await storage.read('notificationList') ?? '[]';
    final List jsonData = json.decode(result);
    notificationsList.clear();
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        addNotification(body: element['body'], title: element['title']);
      }
    }
  }

  Future<bool> changeUserUI() async {
    final token = await Auth().getToken();
    if (token != null) {
      loginUser.value = true;
    } else {
      loginUser.value = false;
    }
    return false;
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

  dynamic switchLang(String value) {
    if (value == 'en') {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tr');
    }
    update();
  }
}
