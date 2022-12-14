// ignore_for_file: file_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/index.dart';

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
  File? selectedImage;

  changeData(String name, String phone, String pubgID) {
    pubgNameController.text = name;
    phoneController.text = phone;
    pubgIDController.text = pubgID;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage = imageTemporary;
      });
    } catch (error) {
      showSnackBar('noConnection3', '$error', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: 'profil'),
      body: FutureBuilder<GetMeModel>(
        future: GetMeModel().getMe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('Empty'));
          }
          changeData(snapshot.data!.nickname!, snapshot.data!.phone!, snapshot.data!.pubgId!);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  textpart('userProfilImage'),
                  Center(
                    child: selectedImage != null
                        ? GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(top: 25),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 15.0, offset: Offset(1.0, 1.0), spreadRadius: 5.0)],
                                ),
                                child: ClipOval(child: Material(elevation: 3, child: Image.file(selectedImage!, fit: BoxFit.cover))),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await Permission.camera.request();
                              await Permission.photos.request();
                              await pickImage();
                            },
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(top: 25),
                                child: DottedBorder(
                                  borderType: BorderType.Oval,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  strokeWidth: 2,
                                  color: kPrimaryColor,
                                  child: const Center(
                                    child: Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: kPrimaryColor,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  textpart('signIn1'),
                  CustomTextField(
                    labelName: '',
                    controller: pubgNameController,
                    borderRadius: true,
                    focusNode: pubgNameFocusNode,
                    requestfocusNode: phoneFocusNode,
                    isNumber: false,
                    disabled: true,
                  ),
                  textpart('signIn2'),
                  CustomTextField(
                    labelName: '',
                    controller: pubgIDController,
                    borderRadius: true,
                    focusNode: pubgIDFocusNode,
                    requestfocusNode: pubgNameFocusNode,
                    isNumber: false,
                    disabled: true,
                  ),
                  textpart('userPhoneNumber'),
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
                  AgreeButton(
                    name: 'agree',
                    onTap: () {
                      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                      GetMeModel().shortUpdate(pubgUserId: pubgIDController.text, pubgUserName: pubgNameController.text).then((value) {
                        if (value == 200) {
                          Get.back();
                          showSnackBar('copySucces', 'changedData', Colors.green);
                          pubgNameController.clear();
                          pubgIDController.clear();
                        } else {
                          showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                        }
                        Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                      });
                    },
                  )
                ],
              ),
            ),
          );
        },
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
        style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: josefinSansBold),
      ),
    );
  }
}
