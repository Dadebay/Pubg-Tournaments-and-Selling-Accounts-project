// ignore_for_file: file_names

import 'package:game_app/constants/ProfilButton.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';
import 'package:game_app/controllers/WalletController.dart';
import 'package:game_app/models/UserModels/AuthModel.dart';
import 'package:game_app/views/UserProfil/Pages/FavPage.dart';
import 'package:game_app/views/UserProfil/Pages/HistoryOrdersPage.dart';
import 'package:game_app/views/UserProfil/Pages/ProfileSettings.dart';
import 'package:game_app/views/UserProfil/Pages/Settings.dart';

import 'Auth/TabbarView.dart';
import 'Pages/AboutUs.dart';
import 'Pages/Cash.dart';
import 'Pages/EditWorkProfil.dart';
import 'Pages/FAQs.dart';

class UserProfil extends StatefulWidget {
  const UserProfil({Key? key}) : super(key: key);

  @override
  State<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  final SettingsController settingsController = Get.put(SettingsController());
  @override
  void initState() {
    super.initState();
    changeUI();
  }

  changeUI() async {
    final token = await Auth().getToken();
    if (token != null) {
      settingsController.loginUser.value = true;
    } else {
      settingsController.loginUser.value = false;
    }
  }

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
              settingsController.loginUser.value
                  ? ProfilButton(
                      name: "profil",
                      onTap: () {
                        Get.to(() => const ProfileSettings());
                      },
                      icon: IconlyLight.profile)
                  : const SizedBox.shrink(),
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
