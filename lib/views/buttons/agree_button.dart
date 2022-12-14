// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/controllers/settings_controller.dart';

import '../constants/index.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;
  final String name;

  AgreeButton({
    required this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        return animatedContaner();
      }),
    );
  }

  AnimatedContainer animatedContaner() {
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
                height: 28,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            )
          : Text(
              name.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 22),
            ),
    );
  }
}
