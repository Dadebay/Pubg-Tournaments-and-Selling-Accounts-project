// ignore_for_file: file_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController pubgNameController = TextEditingController();
  FocusNode pubgNameFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  TextEditingController pubgIDController = TextEditingController();
  FocusNode pubgIDFocusNode = FocusNode();

  changeData(String name, String phone, String pubgID) {
    pubgNameController.text = name;
    phoneController.text = phone;
    pubgIDController.text = pubgID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: "profil"),
      body: FutureBuilder<GetMeModel>(
          future: GetMeModel().getMe(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else if (snapshot.data == null) {
              return const Center(child: Text("Empty"));
            }
            changeData(snapshot.data!.nickname!, snapshot.data!.phone!, snapshot.data!.pubgId!);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    textpart("signIn1"),
                    CustomTextField(
                      labelName: "",
                      controller: pubgNameController,
                      borderRadius: true,
                      focusNode: pubgNameFocusNode,
                      requestfocusNode: phoneFocusNode,
                      isNumber: false,
                      disabled: true,
                    ),
                    textpart("signIn2"),
                    CustomTextField(
                      labelName: "",
                      controller: pubgIDController,
                      borderRadius: true,
                      focusNode: pubgIDFocusNode,
                      requestfocusNode: pubgNameFocusNode,
                      isNumber: false,
                      disabled: true,
                    ),
                    textpart("userPhoneNumber"),
                    PhoneNumber(
                      mineFocus: phoneFocusNode,
                      controller: phoneController,
                      requestFocus: pubgIDFocusNode,
                      style: false,
                      disabled: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AgreeButton(onTap: () {
                      showSnackBar("Succesful", "Succefully Changed name", kPrimaryColor);
                      Get.back();
                    })
                  ],
                ),
              ),
            );
          }),
    );
  }

  Padding textpart(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 30),
      child: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: josefinSansMedium),
      ),
    );
  }
}
