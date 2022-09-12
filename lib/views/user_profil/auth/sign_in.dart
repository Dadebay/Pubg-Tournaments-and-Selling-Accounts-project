// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';
import 'package:game_app/views/user_profil/auth/otp_check.dart';

class SingIn extends StatelessWidget {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final _signUp = GlobalKey<FormState>();

  SingIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _signUp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Text(
                'signInDialog'.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
              ),
            ),
            CustomTextField(labelName: 'signIn1', controller: fullNameController, focusNode: fullNameFocusNode, requestfocusNode: idFocusNode, borderRadius: true, isNumber: false),
            CustomTextField(labelName: 'signIn2', controller: idController, focusNode: idFocusNode, requestfocusNode: phoneNumberFocusNode, borderRadius: true, isNumber: false),
            PhoneNumber(
              mineFocus: phoneNumberFocusNode,
              controller: phoneNumberController,
              requestFocus: fullNameFocusNode,
              style: false,
            ),
            AgreeButton(onTap: onTapp)
          ],
        ),
      ),
    );
  }

  dynamic onTapp() {
    if (_signUp.currentState!.validate()) {
      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
      UserSignInModel().signUp(username: fullNameController.text, pubgID: idController.text, phoneNumber: phoneNumberController.text).then((value) {
        if (value == 200) {
          Get.to(
            () => OtpCheck(
              phoneNumber: phoneNumberController.text,
            ),
          );
        } else if (value == 409) {
          showSnackBar('noConnection3', 'alreadyExist', Colors.red);
        } else {
          showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
        }
      });
    } else {
      showSnackBar('tournamentInfo14', 'errorEmpty', Colors.red);
    }
    Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
  }
}
