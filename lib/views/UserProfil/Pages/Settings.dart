// ignore_for_file: file_names, deprecated_member_use

import 'package:game_app/constants/setttingsButton.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(
        backArrow: true,
        iconRemove: true,
        fontSize: 0.0,
        name: "settings",
        elevationWhite: true,
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 1,
            color: backgroundColor,
            height: 1,
          ),
          SettingButton(
              name: Get.locale!.toLanguageTag() == "tr" ? "Türkmen dili" : "Rus dili",
              onTap: () {
                changeLanguage();
              },
              icon: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: ClipRRect(
                    borderRadius: borderRadius30,
                    child: Image.asset(
                      Get.locale!.toLanguageTag() == "tr" ? tmIcon : ruIcon,
                      fit: BoxFit.cover,
                    ),
                  ))),
          SettingButton(
              name: "termsAndCondition",
              onTap: () {
                termsAndConditionWidget();
              },
              icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.arrowRightCircle,
                    color: Colors.white,
                  ))),
          // SettingButton(
          //     name: "login".tr,
          //     onTap: () {
          //       Get.to(() => const ForgotPassword());
          //     },
          //     icon: IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           IconlyLight.arrowRightCircle,
          //           color: Colors.white,
          //         ))),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(
              color: Colors.grey,
              thickness: 2,
            ),
          ),
          SettingButton(
              name: "versia",
              onTap: () {},
              icon: const Text(
                "1.0.0",
                style: TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium),
              )),
          SettingButton(
              name: "share",
              onTap: () {
                Share.share('https://play.google.com/store/apps/details?id=com.bilermennesil.gamysh', subject: 'Pubg House');
              },
              icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.arrowRightCircle,
                    color: Colors.white,
                  ))),
          SettingButton(
              name: "giveLike",
              onTap: () {
                _launchURL('https://play.google.com/store/apps/details?id=com.bilermennesil.gamysh');
              },
              icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.arrowRightCircle,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
