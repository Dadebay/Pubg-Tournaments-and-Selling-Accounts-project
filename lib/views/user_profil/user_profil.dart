// ignore_for_file: file_names

import 'package:game_app/views/constants/profile_button.dart';
import 'package:game_app/views/constants/dialogs.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';
import 'package:game_app/views/user_profil/pages/add_cash.dart';
import 'package:game_app/views/user_profil/pages/edit_work_profil.dart';
import 'package:game_app/views/user_profil/pages/history_orders_page.dart';
import 'package:game_app/views/user_profil/pages/profile_settings.dart';
import 'package:game_app/views/user_profil/pages/settings.dart';

import '../../controllers/wallet_controller.dart';
import 'Pages/about_us.dart';
import 'Pages/faq.dart';
import 'auth/tab_bar_view.dart';
import 'pages/notification.dart';

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
    Get.find<WalletController>().getUserMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(
        backArrow: false,
        fontSize: 0.0,
        iconRemove: false,
        icon: userAppBarMoney(),
        name: 'profil',
        elevationWhite: true,
      ),
      body: FutureBuilder<GetMeModel>(
        future: GetMeModel().getMe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return errorData(onTap: () {});
          } else if (snapshot.data == null) {
            return emptyData();
          }
          return Obx(() {
            return ListView(
              children: [
                settingsController.loginUser.value
                    ? ProfilButton(
                        name: 'profil',
                        onTap: () {
                          Get.to(() => ProfileSettings(
                                image: snapshot.data!.image!,
                              ));
                        },
                        icon: IconlyLight.profile,
                      )
                    : const SizedBox.shrink(),
                ProfilButton(
                  name: 'settings',
                  onTap: () {
                    Get.to(() => const Settings());
                  },
                  icon: IconlyLight.setting,
                ),
                ProfilButton(
                  name: 'notification',
                  onTap: () {
                    Get.to(() => NotificationPage());
                  },
                  icon: IconlyLight.notification,
                ),
                settingsController.loginUser.value ? whenUserLogin(snapshot.data!.forSale!, snapshot.data!) : const SizedBox.shrink(),
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
                // ProfilButton(
                //   name: 'referalKod',
                //   onTap: () {
                //     settingsController.loginUser.value ? Get.to(() => ReferalPage(referalcode: snapshot.data!.ref_code, used_refcode: snapshot.data!.used_ref_code)) : showSnackBar('loginError', 'loginError1', Colors.red);
                //   },
                //   icon: IconlyLight.ticketStar,
                // ),
                loginLogout(),
              ],
            );
          });
        },
      ),
    );
  }

  ProfilButton loginLogout() {
    return ProfilButton(
      name: settingsController.loginUser.value ? 'log_out' : 'signUp',
      onTap: () {
        settingsController.loginUser.value
            ? logOut()
            : defaultBottomSheet(
                child: Column(
                  children: [
                    ProfilButton(
                      name: 'loginWithPhone',
                      onTap: () {
                        Get.to(
                          () => const TabBarViewPage(
                            loginType: false,
                          ),
                        );
                      },
                      icon: IconlyLight.profile,
                    ),
                    SizedBox(
                      height: 20,
                    )
                    // ProfilButton(
                    //   name: 'loginWithGmail',
                    //   onTap: () {
                    //     Get.to(
                    //       () => const TabBarViewPage(
                    //         loginType: true,
                    //       ),
                    //     );
                    //   },
                    //   icon: Icons.mail_outline,
                    // ),
                  ],
                ),
                name: 'signUp',
              );
      },
      icon: IconlyLight.login,
    );
  }

  Column whenUserLogin(bool forSale, GetMeModel model) {
    return Column(
      children: [
        ProfilButton(
          name: 'cashHistory',
          onTap: () {
            Get.to(
              () => AskMoneyPage(
                text: 'message',
                textSend: 'requestCash'.tr,
              ),
            );
          },
          icon: IconlyLight.wallet,
        ),
        forSale
            ? ProfilButton(
                name: 'editProfil',
                onTap: () {
                  Get.to(
                    () => EditWorkProfile(
                      model: model,
                    ),
                  );
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
