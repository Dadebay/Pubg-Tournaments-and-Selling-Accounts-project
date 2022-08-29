import 'package:flutter/cupertino.dart';
import 'package:game_app/constants/index.dart';

import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:restart_app/restart_app.dart';

void logOut(BuildContext context) {
  Get.bottomSheet(Container(
    decoration: const BoxDecoration(color: kPrimaryColorBlack),
    child: Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Text(
                "log_out".tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.white),
              )
            ],
          ),
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text("log_out_title".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontFamily: josefinSansMedium,
                fontSize: 16,
              )),
        ),
        GestureDetector(
          onTap: () async {
            await Auth().logout();
            Get.back();
            Restart.restartApp();
          },
          child: Container(
            width: Get.size.width,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey[500], borderRadius: borderRadius10),
            child: Text(
              "yes".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Get.back();
          },
          child: Container(
            width: Get.size.width,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.red, borderRadius: borderRadius10),
            child: Text(
              "no".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  ));
}

void changeLanguage() {
  final SettingsController _settingsController = Get.put(SettingsController());

  Get.bottomSheet(Container(
    padding: const EdgeInsets.only(bottom: 20),
    decoration: const BoxDecoration(color: kPrimaryColorBlack),
    child: Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Text(
                "select_language".tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.white),
              )
            ],
          ),
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
              onTap: () {
                _settingsController.switchLang("tr");
                Get.back();
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  tmIcon,
                ),
                backgroundColor: Colors.white,
                radius: 20,
              ),
              title: const Text(
                "Türkmen",
                style: TextStyle(fontFamily: josefinSansMedium, color: Colors.white),
              )),
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
              onTap: () {
                _settingsController.switchLang("ru");
                Get.back();
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  ruIcon,
                ),
                radius: 20,
                backgroundColor: Colors.white,
              ),
              title: const Text(
                "Русский",
                style: TextStyle(fontFamily: josefinSansMedium, color: Colors.white),
              )),
        ),
      ],
    ),
  ));
}

Future termsAndConditionWidget() {
  return Get.bottomSheet(
    Container(
      color: kPrimaryColorBlack,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  "termsAndCondition".tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark, size: 22, color: Colors.white),
                )
              ],
            ),
          ),
          customDivider(),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  loremImpsum,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: josefinSansRegular, color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: false,
  );
}

void defaultBottomSheet({required String name, required Widget child}) {
  Get.bottomSheet(Container(
    decoration: const BoxDecoration(color: kPrimaryColorBlack),
    child: Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Text(
                name.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.white),
              )
            ],
          ),
        ),
        customDivider(),
        Center(
          child: child,
        )
      ],
    ),
  ));
}

Future<dynamic> selectCityAdd({required Function() onTap}) {
  return Get.defaultDialog(
      barrierDismissible: false,
      title: "selectCityTitle".tr,
      titleStyle: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
      radius: 5,
      backgroundColor: kPrimaryColorBlack,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      contentPadding: EdgeInsets.zero,
      content: Column(
        children: [
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Asgabat".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Ahal".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Mary".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Lebap".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Daşoguz".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
          customDivider(),
          TextButton(
            onPressed: onTap,
            child: Text(
              "Balkan".tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
            ),
          ),
        ],
      ));
}
