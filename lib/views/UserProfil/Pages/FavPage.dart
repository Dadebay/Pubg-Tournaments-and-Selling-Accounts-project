// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/WalletController.dart';

class FavPage extends StatelessWidget {
  FavPage({Key? key}) : super(key: key);
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(
        backArrow: true,
        iconRemove: true,
        fontSize: 0.0,
        name: "favorites",
        elevationWhite: true,
        icon: IconButton(
            onPressed: () {
              showDeleteDialog(context, "deleteFav", "deleteFavSub", () {});
            },
            icon: const Icon(
              IconlyLight.delete,
              color: Colors.white,
            )),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.favList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15, childAspectRatio: 2 / 3, crossAxisSpacing: 15),
              itemBuilder: (BuildContext context, int index) {
                return const Text("a");
                // ShowAllProductsCard(
                //   model: AccountsForSaleModel.fromJson(controller.favList[index]),
                //   fav: true,
                // );
              }),
        );
      }),
    );
  }
}
