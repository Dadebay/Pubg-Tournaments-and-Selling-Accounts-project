// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/UserModels/UserSignInModel.dart';
import 'package:game_app/views/UserProfil/Auth/OTPCheck.dart';

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
                "signInDialog".tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
              ),
            ),
            CustomTextField(labelName: "signIn1", controller: fullNameController, focusNode: fullNameFocusNode, requestfocusNode: idFocusNode, borderRadius: true, isNumber: false),
            CustomTextField(labelName: "signIn2", controller: idController, focusNode: idFocusNode, requestfocusNode: phoneNumberFocusNode, borderRadius: true, isNumber: false),
            PhoneNumber(
              mineFocus: phoneNumberFocusNode,
              controller: phoneNumberController,
              requestFocus: fullNameFocusNode,
              style: false,
            ),
            AgreeButton(onTap: () {
              // Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
              if (_signUp.currentState!.validate()) {
                UserSignInModel().signUp(username: fullNameController.text, pubgID: idController.text, phoneNumber: phoneNumberController.text).then((value) {
                  if (value == true) {
                    Get.to(() => OtpCheck(
                          phoneNumber: phoneNumberController.text,
                        ));
                  } else {
                    showSnackBar("Status Code", "$value", Colors.red);
                  }
                });
              } else {
                showSnackBar("Maglumatlar Doldur", "Doldur su maglumatlary", Colors.red);
              }
              // Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
            })
          ],
        ),
      ),
    );
  }
}
