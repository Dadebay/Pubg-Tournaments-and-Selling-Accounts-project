import 'package:game_app/app/data/services/user_detail_services/get_me_service.dart';
import 'package:get/get.dart';

import '../../../data/models/auth_view_models/auth_model.dart';

class AuthController extends GetxController {
  RxBool blockedUser = false.obs;
  dynamic findIfUserBlockedOrNot() async {
    String? token = await Auth().getToken();
    print(token);
    if (token != null) {
      GetMeServices().getMe().then((value) {
        if (value.blocked == true) {
          blockedUser.value = true;
        }
      });
    } else {
      blockedUser.value = false;
    }
  }
}
