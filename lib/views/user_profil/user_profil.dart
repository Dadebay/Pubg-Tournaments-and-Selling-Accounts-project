// ignore_for_file: file_names

import 'package:game_app/constants/profile_button.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';
import 'package:game_app/views/user_profil/Pages/history_orders_page.dart';
import 'package:game_app/views/user_profil/Pages/settings.dart';
import 'package:game_app/views/user_profil/Pages/profile_settings.dart';
import 'package:game_app/views/user_profil/pages/add_cash.dart';
import 'package:game_app/views/user_profil/pages/edit_work_profil.dart';

import 'Auth/tab_bar_view.dart';
import 'Pages/about_us.dart';
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
        name: 'profil',
        elevationWhite: true,
      ),
      body: FutureBuilder<GetMeModel>(
        future: GetMeModel().getMe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return cannotLoadData(
              withButton: true,
              onTap: () {},
              text: 'tournamentInfo14'.tr,
            );
          } else if (snapshot.data == null) {
            return cannotLoadData(
              withButton: true,
              onTap: () {},
              text: 'tournamentInfo14'.tr,
            );
          }
          return Obx(() {
            return ListView(
              children: [
                settingsController.loginUser.value ? whenUserLogin2() : const SizedBox.shrink(),
                ProfilButton(
                  name: 'settings',
                  onTap: () {
                    Get.to(() => const Settings());
                  },
                  icon: IconlyLight.setting,
                ),
                settingsController.loginUser.value ? whenUserLogin(snapshot.data!.phone.toString(), snapshot.data!.forSale!, snapshot.data!) : const SizedBox.shrink(),
                ProfilButton(
                  name: 'questions',
                  onTap: () {
                    Get.to(() => const FAQs());
                  },
                  icon: IconlyLight.document,
                ),
                ProfilButton(
                  name: 'aboutUs',
                  onTap: () {
                    Get.to(() => const AboutUs());
                  },
                  icon: IconlyLight.user3,
                ),
                ProfilButton(
                  name: settingsController.loginUser.value ? 'log_out' : 'signUp',
                  onTap: () {
                    settingsController.loginUser.value ? logOut() : Get.to(() => const TabBarViewPage());
                  },
                  icon: IconlyLight.login,
                ),
              ],
            );
          });
        },
      ),
    );
  }

  ProfilButton whenUserLogin2() {
    return ProfilButton(
      name: 'profil',
      onTap: () {
        Get.to(() => const ProfileSettings());
      },
      icon: IconlyLight.profile,
    );
  }

  Column whenUserLogin(String phoneNumber, bool forSale, GetMeModel model) {
    return Column(
      children: [
        ProfilButton(
          name: 'cashHistory',
          onTap: () {
            Get.to(
              () => AddCash(
                phoneNumber: phoneNumber,
              ),
            );
          },
          icon: IconlyLight.wallet,
        ),
        forSale
            ? ProfilButton(
                name: 'editProfil',
                onTap: () {
                  Get.to(() => EditWorkProfile(
                        model: model,
                      ));
                },
                icon: IconlyLight.category,
              )
            : const SizedBox.shrink(),
        ProfilButton(
          name: 'orders',
          onTap: () {
            Get.to(() => const HistoryOrdersPage());
          },
          icon: IconlyLight.document,
        ),
        divider(),
      ],
    );
  }
}
