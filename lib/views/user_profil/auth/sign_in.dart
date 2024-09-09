// ignore_for_file: file_names, must_be_immutable

import '../../constants/index.dart';

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
  TextEditingController referalKodController = TextEditingController();
  FocusNode referalKodFocusNode = FocusNode();
  TextEditingController gmailController = TextEditingController();
  FocusNode gmailFocusNode = FocusNode();
  final _signUp = GlobalKey<FormState>();
  final bool loginType;

  SingIn({super.key, required this.loginType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _signUp,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 14, top: 25),
                child: Text(
                  'signInDialog'.tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                ),
              ),
              CustomTextField(labelName: 'signIn1', controller: fullNameController, focusNode: fullNameFocusNode, requestfocusNode: idFocusNode, borderRadius: true, isNumber: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(labelName: 'signIn2', controller: idController, focusNode: idFocusNode, requestfocusNode: loginType ? gmailFocusNode : phoneNumberFocusNode, borderRadius: true, isNumber: false),
              ),
              loginType
                  ? CustomTextField(labelName: 'Gmail', controller: gmailController, focusNode: gmailFocusNode, requestfocusNode: referalKodFocusNode, borderRadius: true, isNumber: false)
                  : PhoneNumber(
                      mineFocus: phoneNumberFocusNode,
                      controller: phoneNumberController,
                      requestFocus: referalKodFocusNode,
                      style: false,
                    ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: CustomTextField(
              //     labelName: 'referalKod',
              //     controller: referalKodController,
              //     focusNode: referalKodFocusNode,
              //     requestfocusNode: fullNameFocusNode,
              //     borderRadius: true,
              //     isNumber: false,
              //     isValidate: false,
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: AgreeButton(
                  onTap: onTapp,
                  name: 'agree',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic onTapp() {
    if (_signUp.currentState!.validate()) {
      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
      if (loginType == true) {
        UserSignInModel().signUp(username: fullNameController.text, pubgID: idController.text, phoneNumber: gmailController.text, referalCode: referalKodController.text).then((value) {
          if (value == 200) {
            Get.to(
              () => OtpCheck(
                phoneNumber: gmailController.text,
                loginType: loginType,
              ),
            );
          } else if (value == 409) {
            showSnackBar('noConnection3', 'alreadyExist', Colors.red);
          } else if (value == 400) {
            showSnackBar('refCodeError', 'refCodeError1', Colors.red);
          } else {
            showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
          }
          Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
        });
      } else {
        UserSignInModel().signUp(username: fullNameController.text, pubgID: idController.text, phoneNumber: phoneNumberController.text, referalCode: referalKodController.text).then((value) {
          if (value == 200) {
            Get.to(
              () => OtpCheck(
                phoneNumber: phoneNumberController.text,
                loginType: loginType,
              ),
            );
          } else if (value == 409) {
            showSnackBar('noConnection3', 'alreadyExist', Colors.red);
          } else if (value == 400) {
            showSnackBar('referal yalnys', 'Refereal kod yalys', Colors.red);
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
