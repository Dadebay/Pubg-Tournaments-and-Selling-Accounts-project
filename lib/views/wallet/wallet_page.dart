import 'package:game_app/cards/uc_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/index_model.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:game_app/views/Wallet/order_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final WalletController walletController = Get.put(WalletController());
  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().getUserMoney();
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
      body: FutureBuilder<List<UcModel>>(
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return UCCard(
                      model: snapshot.data![index],
                    );
                  });
            }
            return const Text("last ");
          }),
    );
  }

  ElevatedButton orderButton() {
    return ElevatedButton(
        onPressed: () async {
          final token = await Auth().getToken();
          if (token != null) {
            double value = 0.0;
            for (var element in walletController.cartList) {
              value += double.parse(element["price"]) * element["count"];
            }
            String userName = "";
            await AccountByIdModel().getMe().then((value) {
              setState(() {
                userName = value.pubgUsername.toString();
              });
            });
            Get.find<WalletController>().finalPRice.value = value;
            Get.to(() => OrderPage(
                  userName: userName,
                ));
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
}
