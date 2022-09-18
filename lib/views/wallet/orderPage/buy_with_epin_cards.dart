import 'package:game_app/cards/uc_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'buy_with_epin_order.dart';

class BuyWithEpinCards extends StatefulWidget {
  const BuyWithEpinCards({Key? key}) : super(key: key);

  @override
  State<BuyWithEpinCards> createState() => _BuyWithEpinCardsState();
}

class _BuyWithEpinCardsState extends State<BuyWithEpinCards> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final WalletController walletController = Get.put(WalletController());

  ElevatedButton orderButton() {
    return ElevatedButton(
      onPressed: () async {
        final token = await Auth().getToken();
        if (token != null) {
          double value = 0.0;
          for (var element in walletController.cartList) {
            value += double.parse(element['price']) * element['count'];
          }
          walletController.finalPRice.value = value;
          await Get.to(
            () => const BuyWithEpin(),
          );
        } else {
          showSnackBar('noConnection3', 'order_error_subtitle', Colors.red);
        }
      },
      style: ElevatedButton.styleFrom(elevation: 1, backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius15), padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'order'.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 8),
            child: Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.find<WalletController>().getUserMoney();
    _refreshController.refreshCompleted();
  }

  // ignore: member-ordering-extended
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: MyAppBar(backArrow: true, fontSize: 18.0, iconRemove: false, icon: userAppBarMoney(), elevationWhite: true, name: 'Pubg UC'),
        // ignore: prefer-extracting-callbacks
        floatingActionButton: Obx(() {
          return AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: orderButton(),
            crossFadeState: walletController.cartList.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
            alignment: Alignment.center,
            sizeCurve: Curves.easeInOut,
          );
        }),
        body: SmartRefresher(
          footer: footer(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          enablePullDown: true,
          enablePullUp: false,
          physics: const BouncingScrollPhysics(),
          header: const MaterialClassicHeader(
            color: kPrimaryColor,
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 100),
            child: FutureBuilder<List<UcModel>>(
              future: UcModel().getUCS(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.data == []) {
                  return const Center(child: Text('Empty'));
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) {
                      return UCCard(
                        model: snapshot.data![index],
                      );
                    },
                  );
                }
                return const Text('last ');
              },
            ),
          ),
        ),
      ),
    );
  }
}
