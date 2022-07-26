// ignore_for_file: file_names

import 'package:game_app/models/index_model.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';

import '../views/constants/index.dart';

class WalletController extends GetxController {
  final storage = GetStorage();

  RxDouble finalPRice = 0.0.obs;
  RxList cartList = [].obs;
  RxString userMoney = '0.0'.obs;

  dynamic addCart({required UcModel ucModel}) {
    if (cartList.isEmpty) {
      cartList.add({
        'id': ucModel.id,
        'count': 1,
        'price': ucModel.price,
        'name': ucModel.title,
        'image': ucModel.image,
      });
    } else {
      bool value = false;
      for (var element in cartList) {
        if (element['id'] == ucModel.id) {
          value = true;
          element['count']++;
        }
      }
      if (!value) {
        cartList.add({
          'id': ucModel.id,
          'count': 1,
          'price': ucModel.price,
          'name': ucModel.title,
          'image': ucModel.image,
        });
      }
    }
    storage.write('cart', cartList);
  }

  dynamic removeCart(int id) {
    cartList.removeWhere((element) => element['id'] == id);
    storage.write('cart', cartList);
  }

  dynamic getUserMoney() async {
    final token = await Auth().getToken();
    if (token != null) {
      await AccountByIdModel().getMe().then((value) {
        userMoney.value = value.points.toString();
      });
    } else {
      userMoney.value = '0.0';
    }
  }
}
