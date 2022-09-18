import 'package:game_app/cards/walletPageCard.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';

import 'orderPage/buy_with_epin_cards.dart';
import 'orderPage/buy_with_id.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(backArrow: false, fontSize: 0.0, iconRemove: false, icon: userAppBarMoney(), elevationWhite: true, name: 'Pubg UC'),
      body: Column(
        children: [
          WalletPageCard(
            image: epinImage,
            text: 'buyEpin',
            size: MediaQuery.of(context).size,
            ontapp: () {
              Get.find<SettingsController>().agreeButton.value = false;

              Get.find<WalletController>().finalPRice.value = 0.0;
              Get.to(() => const BuyWithEpinCards());
            },
          ),
          WalletPageCard(
            image: idImage,
            text: 'buyID',
            size: MediaQuery.of(context).size,
            ontapp: () {
              Get.find<SettingsController>().agreeButton.value = false;

              Get.find<WalletController>().finalPRice.value = 0.0;
              Get.find<WalletController>().cartList.clear();
              Get.to(
                () => const BuyWithID(),
              );
            },
          )
        ],
      ),
    );
  }
}
