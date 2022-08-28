// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/ucModels.dart';

class WalletController extends GetxController {
  final storage = GetStorage();
  RxList cartList = [].obs;
  RxList favList = [].obs;

  dynamic addCart({required UcModel ucModel}) {
    if (cartList.isEmpty) {
      cartList.add({
        "id": ucModel.id,
        "count": 1,
        "price": ucModel.price,
        "name": ucModel.title,
        "image": ucModel.image,
      });
    } else {
      bool value = false;
      for (var element in cartList) {
        if (element["id"] == ucModel.id) {
          value = true;
          element["count"]++;
        }
      }
      if (value == false) {
        cartList.add({
          "id": ucModel.id,
          "count": 1,
          "price": ucModel.price,
          "name": ucModel.title,
          "image": ucModel.image,
        });
      }
    }
    storage.write("cart", cartList);
  }

  dynamic removeCart(int id) {
    cartList.removeWhere((element) => element["id"] == id);
    storage.write("cart", cartList);
  }

  // dynamic returnCartList() async {
  //   final List list = await storage.read('cart');
  //   print(list);
  // }

  dynamic addFavList({required int id, required String price, required String name, required String image, required String pubID}) {
    if (favList.isEmpty) {
      favList.add({"id": id, "price": price, "name": name, "image": image, "pugID": pubID});
    } else {
      bool value = false;
      for (var element in favList) {
        if (element["id"] == id) {
          value = true;
        }
      }
      if (value == false) {
        favList.add({"id": id, "price": price, "name": name, "image": image, "pugID": pubID});
      }
    }
    storage.write("favList", favList);
  }

  dynamic removeFav(int id) {
    favList.removeWhere((element) => element["id"] == id);
    storage.write("favList", favList);
  }
}
