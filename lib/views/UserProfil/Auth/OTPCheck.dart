// ignore_for_file: file_names, must_be_immutable

import 'package:game_app/bottomNavBar.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/UserModels/UserSignInModel.dart';

class OtpCheck extends StatelessWidget {
  OtpCheck({Key? key, required this.phoneNumber}) : super(key: key);
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  final _otpCheck = GlobalKey<FormState>();
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: false, name: "Otp check", elevationWhite: false),
        body: Container(
          color: kPrimaryColorBlack,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Please enter the otp sms code",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansMedium),
                ),
              ),
              Form(key: _otpCheck, child: CustomTextField(labelName: "otp", controller: otpController, focusNode: otpFocusNode, requestfocusNode: otpFocusNode, borderRadius: true, isNumber: true)),
              AgreeButton(onTap: () {
                if (_otpCheck.currentState!.validate()) {
                  UserSignInModel().otpCheck(otp: otpController.text, phoneNumber: phoneNumber).then((value) {
                    if (value == true) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                        return const BottomNavBar();
                      }));
                    } else {
                      showSnackBar("Status Code", "$value", Colors.red);
                    }
                  });
                } else {
                  showSnackBar("Maglumatlar Doldur", "Doldur su maglumatlary", Colors.red);
                }
              })
            ],
          ),
        ));
  }
}
