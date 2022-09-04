// ignore_for_file: file_names

import 'package:game_app/constants/profile_button.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/views/user_profil/Pages/fav_page.dart';
import 'package:game_app/views/user_profil/Pages/history_orders_page.dart';
import 'package:game_app/views/user_profil/Pages/settings.dart';
import 'package:game_app/views/user_profil/Pages/profile_settings.dart';
import 'package:game_app/views/user_profil/pages/add_cash.dart';

import 'Auth/tab_bar_view.dart';
import 'Pages/about_us.dart';
import 'Pages/edit_work_profil.dart';
import 'Pages/faq.dart';

class UserProfil extends StatefulWidget {
  const UserProfil({Key? key}) : super(key: key);

  @override
  State<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
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
                            name: "cashHistory",
                            onTap: () {
                              Get.to(() => const AddCash());
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
