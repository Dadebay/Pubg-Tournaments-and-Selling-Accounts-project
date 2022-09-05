import 'package:game_app/cards/uc_card.dart';
import 'package:game_app/constants/dialogs.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:game_app/views/wallet/order_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final WalletController walletController = Get.put(WalletController());

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().getUserMoney();
  }

  final _userIDKEy = GlobalKey<FormState>();
  TextEditingController userIDController = TextEditingController();
  FocusNode userIDFocusNode = FocusNode();

  ElevatedButton orderButton() {
    return ElevatedButton(
        onPressed: () async {
          final token = await Auth().getToken();
          if (token != null) {
            double value = 0.0;
            for (var element in walletController.cartList) {
              value += double.parse(element["price"]) * element["count"];
            }
            userIDController.clear();

            defaultBottomSheet(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        walletController.finalPRice.value = value;
                        Get.back();

                        Get.to(() => const OrderPage(
                              orderType: false,
                              userID: "",
                            ));
                      },
                      title: Text(
                        "orderType1".tr,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                      iconColor: Colors.white,
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        walletController.finalPRice.value = value;
                        Get.defaultDialog(
                            backgroundColor: kPrimaryColorBlack,
                            title: "signIn2".tr,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            titlePadding: const EdgeInsets.only(top: 15),
                            titleStyle: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 20),
                            content: Form(
                              key: _userIDKEy,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CustomTextField(
                                      labelName: "signIn2",
                                      controller: userIDController,
                                      focusNode: userIDFocusNode,
                                      requestfocusNode: userIDFocusNode,
                                      isNumber: false,
                                      borderRadius: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_userIDKEy.currentState!.validate()) {
                                            Get.back();
                                            Get.back();
                                            Get.to(() => OrderPage(
                                                  orderType: true,
                                                  userID: userIDController.text,
                                                ));
                                          } else {
                                            showSnackBar("Maglumatlar Doldur", "Doldur su maglumatlary", Colors.red);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14), primary: Colors.white, shape: const RoundedRectangleBorder(borderRadius: borderRadius20)),
                                        child: Text(
                                          "agree".tr,
                                          style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 18),
                                        )),
                                  ),
                                ],
                              ),
                            ));
                      },
                      title: Text(
                        "orderType2".tr,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                      iconColor: Colors.white,
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                name: 'orderType'.tr);
          } else {
            showSnackBar("noConnection3", "order_error_subtitle", Colors.red);
          }
        },
        style: ElevatedButton.styleFrom(elevation: 1, primary: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius15), padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "order".tr,
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
        ));
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.find<WalletController>().getUserMoney();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(backArrow: false, fontSize: 0.0, iconRemove: false, icon: balIcon(), elevationWhite: true, name: "Pubg UC"),
      floatingActionButton: Obx(() {
        return AnimatedCrossFade(
            firstChild: const SizedBox.shrink(), secondChild: orderButton(), crossFadeState: walletController.cartList.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: const Duration(milliseconds: 500), alignment: Alignment.center, sizeCurve: Curves.easeInOut);
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
                  return const Center(child: Text("Error"));
                } else if (snapshot.data == []) {
                  return const Center(child: Text("Empty"));
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
                      });
                }
                return const Text("last ");
              }),
        ),
      ),
    );
  }
}
