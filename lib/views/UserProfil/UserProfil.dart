// ignore_for_file: file_names

import 'package:game_app/constants/ProfilButton.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';
import 'package:game_app/controllers/WalletController.dart';
import 'package:game_app/models/UserModels/AuthModel.dart';
import 'package:game_app/views/UserProfil/Pages/FavPage.dart';
import 'package:game_app/views/UserProfil/Pages/HistoryOrdersPage.dart';
import 'package:game_app/views/UserProfil/Pages/Settings.dart';

import 'Auth/TabbarView.dart';
import 'Pages/AboutUs.dart';
import 'Pages/Cash.dart';
import 'Pages/EditWorkProfil.dart';
import 'Pages/FAQs.dart';
import 'Pages/ProfileSettings.dart';

class UserProfil extends StatelessWidget {
  UserProfil({Key? key}) : super(key: key);
  final SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(
          backArrow: false,
          fontSize: 0.0,
          iconRemove: false,
          name: "profil",
          elevationWhite: true,
        ),
        body: SingleChildScrollView(child: Obx(() {
          return Column(
            children: [
              settingsController.loginUser.value ? topPart() : const SizedBox.shrink(),
              ProfilButton(
                  name: "settings",
                  onTap: () {
                    Get.to(() => const Settings());
                  },
                  icon: IconlyLight.setting),
              Get.find<WalletController>().favList.isNotEmpty
                  ? ProfilButton(
                      name: "favorites",
                      onTap: () {
                        Get.to(() => FavPage());
                      },
                      icon: IconlyLight.heart)
                  : const SizedBox.shrink(),
              settingsController.loginUser.value
                  ? Column(
                      children: [
                        ProfilButton(
                            name: "bal",
                            onTap: () {
                              Get.to(() => const MyCash());
                            },
                            icon: IconlyLight.wallet),
                        ProfilButton(
                            name: "editProfil",
                            onTap: () {
                              Get.to(() => const EditWorkProfile());
                            },
                            icon: IconlyLight.category),
                        ProfilButton(
                            name: "orders",
                            onTap: () {
                              Get.to(() => const HistoryOrdersPage());
                            },
                            icon: IconlyLight.document),
                        divider(),
                      ],
                    )
                  : const SizedBox.shrink(),
              ProfilButton(
                  name: "questions",
                  onTap: () {
                    Get.to(() => const FAQs());
                  },
                  icon: IconlyLight.document),
              ProfilButton(
                  name: "aboutUs",
                  onTap: () {
                    Get.to(() => const AboutUs());
                  },
                  icon: IconlyLight.user3),
              ProfilButton(
                  name: settingsController.loginUser.value ? "log_out" : "signUp",
                  onTap: () {
                    settingsController.loginUser.value ? logOut(context) : Get.to(() => const TabBarViewPage());
                  },
                  icon: IconlyLight.login),
            ],
          );
        })));
  }
}

Widget topPart() {
  return GestureDetector(
    onTap: () {
      Get.to(() => const ProfileSettings());
    },
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          decoration: const BoxDecoration(borderRadius: borderRadius15),
          height: 85,
          width: 85,
          padding: const EdgeInsets.all(5),
          child: const ClipRRect(
            borderRadius: borderRadius20,
            //   child:
            //    Image.asset(
            //     "assets/icons/user.jpg",
            //     fit: BoxFit.cover,
            //   ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  Auth().getToken().then((value) {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Gurbanow Dadebay ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: josefinSansSemiBold),
                      ),
                      Icon(
                        IconlyLight.edit,
                        color: Colors.white,
                        size: 22,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    IconlyLight.wallet,
                    color: Colors.grey,
                    size: 25,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          " - 180 ",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70, fontSize: 18, fontFamily: josefinSansMedium),
                        ),
                      ),
                      Image.asset(
                        "assets/icons/token.png",
                        width: 25,
                        height: 25,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
