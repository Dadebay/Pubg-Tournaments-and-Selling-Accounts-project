// ignore_for_file: file_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:game_app/constants/index.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocsNode = FocusNode();
  @override
  void initState() {
    super.initState();
    nameController.text = "Gurbanow Dadebay";
    phoneController.text = "62 990344";
    emailController.text = "dadebaygurbanow333@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: "profil"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              textpart("fullName"),
              CustomTextField(labelName: "", controller: nameController, borderRadius: true, focusNode: nameFocusNode, requestfocusNode: phoneFocusNode, isNumber: false),
              textpart("phone"),
              PhoneNumber(
                mineFocus: phoneFocusNode,
                controller: phoneController,
                requestFocus: emailFocsNode,
                style: false,
              ),
              textpart("email"),
              CustomTextField(labelName: "", controller: emailController, borderRadius: true, focusNode: emailFocsNode, requestfocusNode: nameFocusNode, isNumber: false),
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
      ),
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
