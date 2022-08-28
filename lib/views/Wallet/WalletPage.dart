import 'package:game_app/cards/uCCard.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/walletController.dart';
import 'package:game_app/models/ucModels.dart';
import 'package:game_app/views/Wallet/orderPage.dart';

class WalletPage extends StatelessWidget {
  WalletPage({Key? key}) : super(key: key);
  final WalletController walletController = Get.put(WalletController());
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
          // future: Get.find<SettingsController>().getData,
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
        onPressed: () {
          double value = 0.0;
          for (var element in walletController.cartList) {
            value += double.parse(element["price"]) * element["count"];
          }

          Get.to(() => OrderPage(
                finalPrice: value,
                userID: "15435",
                userName: "Amanow Aman",
              ));
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
