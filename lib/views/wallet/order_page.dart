// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:game_app/cards/order_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final WalletController walletController = Get.put(WalletController());
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: true, name: "orderPage".tr, elevationWhite: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Obx(() {
                return ListView.builder(
                  itemCount: walletController.cartList.length,
                  itemExtent: 120,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(
                      id: walletController.cartList[index]["id"],
                      image: "$serverURL${walletController.cartList[index]["image"]}",
                      name: walletController.cartList[index]["name"] ?? "Aman",
                      price: walletController.cartList[index]["price"].toString(),
                      count: walletController.cartList[index]["count"],
                    );
                  },
                );
              })),
          customDivider(),
          Expanded(
              flex: 2,
              child: Container(
                color: kPrimaryColorBlack,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "info".tr,
                        style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ask Payment"),
                        CupertinoSwitch(
                            value: value,
                            onChanged: (bool valuee) {
                              setState(() {
                                value = valuee;
                              });
                            })
                      ],
                    ),
                    text("orderPage1", walletController.cartList.length.toString()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: text("orderPage2", widget.userName),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "orderPage3".tr,
                          style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 18),
                        ),
                        Obx(() {
                          return Text(
                            "${Get.find<WalletController>().finalPRice} TMT",
                            style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 20),
                          );
                        }),
                      ],
                    ),
                    Center(
                      child: AgreeButton(onTap: () async {
                        final token = await Auth().getToken();
                        if (token != null) {
                          List list = [];
                          for (var element in walletController.cartList) {
                            list.add({
                              "uc": element["id"],
                              "count": element["count"],
                            });
                          }
                          UcModel().addCart(list, value).then((value) {
                            if (value == true) {
                              Get.find<WalletController>().cartList.clear();
                              Get.find<WalletController>().cartList.refresh();
                              Get.back();
                              showSnackBar("Tassyklandy", "Sizin sargydynyz tassyklandy", Colors.green);
                            } else {
                              showSnackBar("Bir zat yalnys", "Bir zada yalnys gitdi", Colors.red);
                            }
                          });
                        } else {
                          showSnackBar("Ulgama girin", "Sargyt etmek ucin ulgama girin", Colors.red);
                        }
                      }),
                    ),
                  ],
                ),
              )),
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
}
