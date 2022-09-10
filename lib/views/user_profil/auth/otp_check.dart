// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/bottom_nav_bar.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';

class OtpCheck extends StatelessWidget {
  OtpCheck({Key? key, required this.phoneNumber}) : super(key: key);
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  final _otpCheck = GlobalKey<FormState>();
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: false, name: "otp", elevationWhite: false),
        body: Container(
          color: kPrimaryColorBlack,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "otpSubtitle".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansMedium),
                ),
              ),
              Form(key: _otpCheck, child: CustomTextField(labelName: "otp", controller: otpController, focusNode: otpFocusNode, requestfocusNode: otpFocusNode, borderRadius: true, isNumber: true)),
              const SizedBox(
                height: 15,
              ),
              AgreeButton(onTap: () {
                if (_otpCheck.currentState!.validate()) {
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;

                  UserSignInModel().otpCheck(otp: otpController.text, phoneNumber: phoneNumber).then((value) {
                    if (value == true) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                        return const BottomNavBar();
                      }));
                    } else {
                      showSnackBar("tournamentInfo14", "$value", Colors.red);
                    }
                  });
                } else {
                  showSnackBar("tournamentInfo14", "signInDialog", Colors.red);
                }
                Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
              })
            ],
          ),
        ));
  }
}
