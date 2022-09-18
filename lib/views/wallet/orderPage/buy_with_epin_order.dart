// ignore_for_file: file_names

import 'package:game_app/cards/order_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';

class BuyWithEpin extends StatefulWidget {
  const BuyWithEpin({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyWithEpin> createState() => _BuyWithEpinState();
}

class _BuyWithEpinState extends State<BuyWithEpin> {
  final WalletController walletController = Get.put(WalletController());

  // ignore: long-method
  Widget bottomPart() {
    return Container(
      color: kPrimaryColorBlack,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'info'.tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 22),
            ),
          ),
          Obx(() {
            return text('orderPage1', walletController.cartList.length.toString());
          }),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'orderPage3'.tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 18),
                ),
                Obx(() {
                  return Text(
                    '${walletController.finalPRice} TMT',
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 20),
                  );
                }),
              ],
            ),
          ),
          Center(
            child: AgreeButton(
              onTap: () async {
                final token = await Auth().getToken();
                if (token != null) {
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                  final List list = [];
                  for (var element in walletController.cartList) {
                    list.add({
                      'uc': element['id'],
                      'count': element['count'],
                    });
                  }
                  await UcModel().addCart(list, false, '').then((value) {
                    if (value == 200 || value == 500) {
                      walletController.cartList.clear();
                      walletController.cartList.refresh();
                      Get.back();
                      Get.back();
                      Get.find<WalletController>().getUserMoney();
                      showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                    } else if (value == 404) {
                      showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                    } else {
                      showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                    }
                  });
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                } else {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Row text(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1.tr,
          style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 18),
        ),
        Text(
          text2.tr,
          style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: true, name: 'orderPage'.tr, elevationWhite: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Obx(() {
              return walletController.cartList.isEmpty
                  ? noData('Sargyt zat yok')
                  : ListView.builder(
                      itemCount: walletController.cartList.length,
                      itemExtent: 120,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderCard(
                          id: walletController.cartList[index]['id'],
                          image: "$serverURL${walletController.cartList[index]["image"]}",
                          name: walletController.cartList[index]['name'] ?? 'Pubg UC',
                          price: walletController.cartList[index]['price'].toString(),
                          count: walletController.cartList[index]['count'],
                        );
                      },
                    );
            }),
          ),
          customDivider(),
          Expanded(flex: 2, child: bottomPart()),
        ],
      ),
    );
  }
}
