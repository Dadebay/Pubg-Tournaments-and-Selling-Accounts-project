// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';

import '../../constants/index.dart';
import 'otp_check.dart';

class Login extends StatelessWidget {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final login = GlobalKey<FormState>();
  final bool loginType;
  Login({super.key, required this.loginType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: login,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
              child: Text(
                'signInDialog'.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
              ),
            ),
            loginType
                ? CustomTextField(labelName: 'Gmail', controller: phoneNumberController, focusNode: phoneNumberFocusNode, requestfocusNode: phoneNumberFocusNode, borderRadius: true, isNumber: false)
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: PhoneNumber(
                      mineFocus: phoneNumberFocusNode,
                      controller: phoneNumberController,
                      requestFocus: phoneNumberFocusNode,
                      style: false,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AgreeButton(
                  onTap: onTapp,
                  name: 'agree',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  dynamic onTapp() {
    if (login.currentState!.validate()) {
      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
      if (loginType == true) {
        UserSignInModel().gmailLogin(email: phoneNumberController.text).then((value) {
          print("gggggggggggggggkgkgkgkgkgkkg");
          print(value);
          if (value == 200) {
            Get.to(
              () => OtpCheck(
                phoneNumber: phoneNumberController.text,
                loginType: loginType,
              ),
            );
          } else if (value == 404) {
            showSnackBar('userNotFound', 'userNotFound1', Colors.red);
          } else {
            showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
          }
          Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
        });
      } else {
        UserSignInModel().login(phone: phoneNumberController.text).then((value) {
          print("ddddddddddddsssssss");
          print(value);
          if (value == 200) {
            Get.to(
              () => OtpCheck(
                phoneNumber: phoneNumberController.text,
                loginType: loginType,
              ),
            );
          } else if (value == 404) {
            showSnackBar('userNotFound', 'userNotFound1', Colors.red);
          } else {
            showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
          }
          Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
        });
      }
    } else {
      showSnackBar('tournamentInfo14', 'errorEmpty', Colors.red);
    }
  }
}
