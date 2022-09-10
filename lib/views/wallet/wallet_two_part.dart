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
        appBar: const MyAppBar(backArrow: false, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: "Pubg UC"),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.find<WalletController>().finalPRice.value = 0.0;

                Get.to(() => const WalletPage());
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: borderRadius20, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, spreadRadius: 3)]),
                child: ClipRRect(
                    borderRadius: borderRadius20,
                    child: Image.asset(
                      "assets/image/epin.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.find<WalletController>().finalPRice.value = 0.0;
                Get.find<WalletController>().cartList.clear();
                Get.to(() => const OrderPage(
                      orderType: true,
                    ));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                decoration: BoxDecoration(color: kPrimaryColorBlack, borderRadius: borderRadius20, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, spreadRadius: 3)]),
                child: ClipRRect(
                    borderRadius: borderRadius20,
                    child: Image.asset(
                      "assets/image/id.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ));
  }
}
