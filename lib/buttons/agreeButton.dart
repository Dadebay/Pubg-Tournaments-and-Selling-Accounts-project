// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;

  AgreeButton({Key? key, required this.onTap}) : super(key: key);

  final SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        return AnimatedContainer(
          decoration: const BoxDecoration(
            borderRadius: borderRadius20,
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: settingsController.agreeButton.value ? 0 : 10),
          width: settingsController.agreeButton.value ? 60 : Get.size.width,
          duration: const Duration(milliseconds: 1000),
          child: settingsController.agreeButton.value
              ? const Center(
                  child: SizedBox(
                    width: 28,
                    height: 26,
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : Text(
                  "agree".tr,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 24),
                ),
        );
      }),
    );
  }
}
