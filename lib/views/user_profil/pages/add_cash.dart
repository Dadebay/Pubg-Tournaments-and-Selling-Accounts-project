// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_app/buttons/agree_button.dart';
import 'package:game_app/constants/app_bar.dart';
import 'package:game_app/constants/constants.dart';
import 'package:game_app/constants/custom_text_field.dart';
import 'package:game_app/constants/phone_number.dart';
import 'package:game_app/constants/widgets.dart';
import 'package:get/get.dart';

class AddCash extends StatefulWidget {
  const AddCash({Key? key}) : super(key: key);

  @override
  State<AddCash> createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  TextEditingController messageController = TextEditingController();

  FocusNode messageFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();

  final _login = GlobalKey<FormState>();

  bool addCash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: false, elevationWhite: true, name: "bal"),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              print(addCash);

              addCash = !addCash;
              print(addCash);
            });
          },
          child: const Text("Add Cash"),
        ),
        body: AnimatedCrossFade(firstChild: page2(), secondChild: const Center(child: Text("Transaction History Bolmaly")), crossFadeState: addCash ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: const Duration(milliseconds: 800)));
  }

  Widget page2() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(
            "addCash".tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18),
          ),
        ),
        CustomTextField(
          labelName: "fullName",
          borderRadius: true,
          controller: nameController,
          focusNode: nameFocusNode,
          requestfocusNode: phoneFocusNode,
          isNumber: false,
        ),
        PhoneNumber(
          mineFocus: phoneFocusNode,
          controller: phoneController,
          requestFocus: messageFocusNode,
          style: false,
        ),
        CustomTextField(
          maxline: 4,
          borderRadius: true,
          labelName: "message",
          controller: messageController,
          focusNode: messageFocusNode,
          requestfocusNode: nameFocusNode,
          isNumber: false,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: AgreeButton(
            onTap: () {
              if (_login.currentState!.validate()) {
                // AboutUsModel()
                //     .sendMessage(
                //   phone: phoneController.text,
                //   message: messageController.text,
                //   email: emailController.text,
                //   fullname: nameController.text,
                // )
                //     .then((value) {
                //   if (value == true) {
                //     showSnackBar("Sms gitdowwww", "Sms gitdi", Colors.green);
                //   } else {
                //     showSnackBar("Bir zada Gote geydin", "Doldur su teext leri", Colors.red);
                //   }
                // });
              } else {
                showSnackBar("Text Doldur", "Doldur su teext leri", Colors.red);
              }
            },
          ),
        ),
      ],
    );
  }
}
