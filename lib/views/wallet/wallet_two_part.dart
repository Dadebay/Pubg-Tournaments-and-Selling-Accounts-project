import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';

import 'order_page.dart';
import 'wallet_page.dart';

class WalletTwoPage extends StatefulWidget {
  const WalletTwoPage({Key? key}) : super(key: key);

  @override
  State<WalletTwoPage> createState() => _WalletTwoPageState();
}

class _WalletTwoPageState extends State<WalletTwoPage> {
  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().getUserMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: false, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: 'Pubg UC'),
      body: Column(
        children: [
          card(
            MediaQuery.of(context).size,
            () {
              Get.find<WalletController>().finalPRice.value = 0.0;
              Get.to(() => const WalletPage());
            },
            epinImage,
            'buyEpin'.tr,
          ),
          card(
            MediaQuery.of(context).size,
            () {
              Get.find<WalletController>().finalPRice.value = 0.0;
              Get.find<WalletController>().cartList.clear();
              Get.to(
                () => const OrderPage(
                  orderType: true,
                ),
              );
            },
            idImage,
            'buyID'.tr,
          ),
        ],
      ),
    );
  }

  GestureDetector card(Size size, Function() ontapp, String image, String text) {
    return GestureDetector(
      onTap: ontapp,
      child: Stack(
        children: [
          Container(
            height: size.height / 4,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: borderRadius25, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, spreadRadius: 3)]),
            child: ClipRRect(
              borderRadius: borderRadius25,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(
              borderRadius: borderRadius25,
              color: Colors.black12.withOpacity(0.6),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 35),
              ),
            ),
          )
        ],
      ),
    );
  }
}
