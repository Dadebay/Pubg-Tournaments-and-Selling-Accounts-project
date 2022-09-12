// ignore_for_file: file_names

import 'package:game_app/cards/order_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';

class OrderPage extends StatefulWidget {
  final bool orderType;

  const OrderPage({
    required this.orderType,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController pubgUserIDController = TextEditingController();
  FocusNode pubgUserIDFocusNode = FocusNode();
  String title = 'selectUCType'.tr;
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
            padding: EdgeInsets.only(top: widget.orderType ? 20 : 10, bottom: 10),
            child: Text(
              'info'.tr,
              style: TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: widget.orderType ? 22 : 20),
            ),
          ),
          widget.orderType
              ? const SizedBox.shrink()
              : Obx(() {
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
                  if (widget.orderType) {
                    await UcModel().addCart(list, widget.orderType, pubgUserIDController.text).then((value) {
                      if (value == 200) {
                        walletController.cartList.clear();
                        walletController.cartList.refresh();
                        Get.back();
                        showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                      } else if (value == 404) {
                        showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                      } else {
                        showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                      }
                      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                    });
                  } else {
                    await UcModel().addCart(list, widget.orderType, '').then((value) {
                      if (value == 200) {
                        walletController.cartList.clear();
                        walletController.cartList.refresh();
                        Get.back();
                        showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                      } else if (value == 404) {
                        showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                      } else {
                        showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                      }
                      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                    });
                  }
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

  Widget buyWithID() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10),
            child: Text(
              'enterID'.tr,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansSemiBold),
            ),
          ),
          CustomTextField(
            labelName: 'accountDetaile2'.replaceAll(RegExp(r':'), ''),
            controller: pubgUserIDController,
            focusNode: pubgUserIDFocusNode,
            requestfocusNode: pubgUserIDFocusNode,
            isNumber: false,
            borderRadius: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 15, left: 10),
            child: Text(
              'selectUCType'.tr,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansSemiBold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.defaultDialog(
                title: 'selectUCType'.tr,
                titleStyle: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold),
                radius: 15.0,
                backgroundColor: kPrimaryColorBlack,
                titlePadding: const EdgeInsets.symmetric(vertical: 20),
                contentPadding: const EdgeInsets.only(),
                content: FutureBuilder<List<UcModel>>(
                  future: UcModel().getUCS(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: spinKit());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else if (snapshot.data == null) {
                      return const Center(
                        child: Text('Null'),
                      );
                    }
                    return SizedBox(
                      height: Get.size.height / 2,
                      width: Get.size.width / 1,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return UcCard(
                            snapshot,
                            index,
                          );
                        },
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return divider();
                        },
                      ),
                    );
                  },
                ),
              );
            },
            title: Text(
              title,
              style: TextStyle(color: title == 'selectUCType' ? Colors.grey : Colors.white, fontSize: 16, fontFamily: josefinSansRegular),
            ),
            shape: const RoundedRectangleBorder(borderRadius: borderRadius20, side: BorderSide(color: Colors.white, width: 2)),
            trailing: const Icon(IconlyLight.arrowDownCircle, color: Colors.white),
          )
        ],
      ),
    );
  }

  GestureDetector UcCard(
    AsyncSnapshot<List<UcModel>> snapshot,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        title = snapshot.data![index].title!;
        walletController.finalPRice.value = double.parse(snapshot.data![index].price!);
        walletController.cartList.clear();
        walletController.addCart(ucModel: snapshot.data![index]);
        setState(() {});
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                snapshot.data![index].title!,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 17),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Text(
                snapshot.data![index].price!.substring(0, snapshot.data![index].price!.length - 1) + ' TMT',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded buyWithEpin() {
    return Expanded(
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
      body: widget.orderType
          ? ListView(
              children: [
                buyWithID(),
                bottomPart(),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buyWithEpin(),
                customDivider(),
                Expanded(flex: 2, child: bottomPart()),
              ],
            ),
    );
  }
}
