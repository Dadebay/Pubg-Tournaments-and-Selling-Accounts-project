import 'package:flutter/cupertino.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/views/constants/profile_button.dart';
import 'package:game_app/views/user_profil/pages/bought_gifts.dart';
import 'package:game_app/views/user_profil/pages/bought_konkurs.dart';
import 'package:game_app/views/user_profil/pages/history_orders_page.dart';

class BoughtThings extends StatelessWidget {
  const BoughtThings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(fontSize: 18, backArrow: true, iconRemove: false, name: 'orders', elevationWhite: true),
      body: Column(
        children: [
          ProfilButton(
            name: 'boughtGifts',
            onTap: () {
              Get.to(() => const BoughtGifts());
            },
            icon: CupertinoIcons.gift,
          ),
          ProfilButton(
            name: 'boughtKonkurs',
            onTap: () {
              Get.to(() => const BoughtKonkurs());
            },
            icon: CupertinoIcons.gift,
          ),
          ProfilButton(
            name: 'boughtUC',
            onTap: () {
              Get.to(() => const HistoryOrdersPage());
            },
            icon: CupertinoIcons.money_dollar_circle_fill,
          ),
          ProfilButton(
            name: 'boughtCODES',
            onTap: () {
              Get.to(() => const BoughtCODES());
            },
            icon: IconlyLight.document,
          ),
        ],
      ),
    );
  }
}
