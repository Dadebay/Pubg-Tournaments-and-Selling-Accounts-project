// ignore_for_file: file_names

import 'package:game_app/app/constants/buttons/agree_button.dart';
import 'package:game_app/app/constants/cards/order_card.dart';
import 'package:game_app/app/constants/others/app_bar.dart';
import 'package:game_app/app/constants/packages/index.dart';
import 'package:game_app/app/data/models/auth_view_models/auth_model.dart';
import 'package:game_app/app/data/services/uc_view_services/uc_view_services.dart';
import 'package:game_app/app/modules/home/controllers/home_controller.dart';
import 'package:game_app/app/modules/pubg_uc/controllers/pubg_uc_controller.dart';
import 'package:get/get.dart';

import '../../../constants/others/widgets.dart';

class OrderPage extends StatefulWidget {
  final String pubgID;
  const OrderPage({super.key, required this.pubgID});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final PubgUcController walletController = Get.put(PubgUcController());
  @override
  void initState() {
    super.initState();
    walletController.getUserMoney();
  }

  Widget bottomPart() {
    return Container(
      color: kPrimaryColorBlack,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: Text(
              'info'.tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
            ),
          ),
          Obx(() {
            return text('orderPage1', walletController.cartList.length.toString());
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: text('accountDetaile2', widget.pubgID),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'orderPage3'.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
              Obx(() {
                return Text(
                  '${walletController.finalPRice} TMT',
                  style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 20),
                );
              }),
            ],
          ),
          Center(
            child: AgreeButton(
              name: 'agree',
              onTap: () async {
                final token = await Auth().getToken();
                if (token != null) {
                  Get.find<HomeController>().agreeButton.value = !Get.find<HomeController>().agreeButton.value;
                  final List list = [];
                  for (var element in walletController.cartList) {
                    list.add({
                      'uc': element['id'],
                      'count': element['count'],
                    });
                  }
                  await UcViewServices().addCart(list, false, '').then((value) {
                    if (value == 200 || value == 500) {
                      walletController.cartList.clear();
                      walletController.cartList.refresh();
                      Get.back();
                      Get.back();
                      Get.find<PubgUcController>().getUserMoney();
                      showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                    } else if (value == 404) {
                      showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                    } else {
                      showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                    }
                  });
                  Get.find<HomeController>().agreeButton.value = !Get.find<HomeController>().agreeButton.value;
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
          style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
        ),
        Text(
          text2.tr,
          style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(
        fontSize: 0.0,
        backArrow: true,
        icon: userAppBarMoney(),
        iconRemove: false,
        name: 'orderPage'.tr,
        elevationWhite: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Obx(() {
              return walletController.cartList.isEmpty
                  ? noData('Sargyt zat yok')
                  : ListView.builder(
                      itemCount: walletController.cartList.length,
                      itemExtent: size.width >= 800 ? 190 : 140,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderCard(
                          id: walletController.cartList[index]['id'],
                          image: "$serverURL${walletController.cartList[index]["image"]}",
                          title: walletController.cartList[index]['name'] ?? 'Pubg UC',
                          price: walletController.cartList[index]['price'].toString(),
                          count: walletController.cartList[index]['count'],
                        );
                      },
                    );
            }),
          ),
          dividerPadding(),
          Expanded(flex: 3, child: bottomPart()),
        ],
      ),
    );
  }
}
