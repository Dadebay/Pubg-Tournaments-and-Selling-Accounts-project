// ignore_for_file: file_names, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';
import 'package:permission_handler/permission_handler.dart';

class EditWorkProfile extends StatefulWidget {
  final GetMeModel model;
  const EditWorkProfile({required this.model, Key? key}) : super(key: key);

  @override
  State<EditWorkProfile> createState() => _EditWorkProfileState();
}

class _EditWorkProfileState extends State<EditWorkProfile> {
  TextEditingController bioController = TextEditingController();

  FocusNode bioFocusNode = FocusNode();

  FocusNode firstNameFocusNode = FocusNode();

  TextEditingController fisrtNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  FocusNode lastNameFocusNode = FocusNode();

  TextEditingController priceController = TextEditingController();

  FocusNode priceFocusNode = FocusNode();

  TextEditingController pubgIDController = TextEditingController();

  FocusNode pubgIDFocusNode = FocusNode();

  TextEditingController userNameController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    changeData();
  }

  dynamic changeData() {
    userNameController.text = widget.model.nickname.toString();
    pubgIDController.text = widget.model.pubgId.toString();
    fisrtNameController.text = widget.model.firstName.toString();
    lastNameController.text = widget.model.lastName.toString();
    priceController.text = widget.model.price.toString();
    bioController.text = widget.model.bio.toString();
  }

  File? selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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

  File? selectedImage1;

  Future pickImage1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage1 = imageTemporary;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(labelName: 'signIn1', controller: userNameController, focusNode: userNameFocusNode, requestfocusNode: pubgIDFocusNode, isNumber: false, borderRadius: true),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: 'signIn2', controller: pubgIDController, focusNode: pubgIDFocusNode, requestfocusNode: firstNameFocusNode, isNumber: false, borderRadius: true),
              ),
              CustomTextField(labelName: 'enterUserName', controller: fisrtNameController, focusNode: firstNameFocusNode, requestfocusNode: lastNameFocusNode, isNumber: false, borderRadius: true),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomTextField(labelName: 'enterSurname', controller: lastNameController, focusNode: lastNameFocusNode, requestfocusNode: priceFocusNode, isNumber: false, borderRadius: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: 'accountPrice', controller: priceController, focusNode: priceFocusNode, requestfocusNode: bioFocusNode, isNumber: true, borderRadius: true),
              ),
              CustomTextField(
                labelName: 'add_page1',
                controller: bioController,
                focusNode: bioFocusNode,
                requestfocusNode: userNameFocusNode,
                isNumber: false,
                borderRadius: true,
                maxline: 6,
              ),
              selectImageDesign(),
              selectBackImage(),
              AgreeButton(onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  dynamic selectImageDesign() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Text(
            'select_user_image'.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
          ),
        ),
        selectedImage != null
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
              )
      ],
    );
  }

  dynamic selectBackImage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
          child: Text(
            'select_user_bg_image'.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
          ),
        ),
        selectedImage1 != null
            ? GestureDetector(
                onTap: () {
                  pickImage1();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                  height: 170,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 15.0, offset: Offset(1.0, 1.0), spreadRadius: 5.0)],
                  ),
                  child: Material(
                    elevation: 2,
                    borderRadius: borderRadius15,
                    child: ClipRRect(
                      borderRadius: borderRadius15,
                      child: Image.file(selectedImage1!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () async {
                  await pickImage1();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 25, right: 10, top: 10),
                  height: 150,
                  width: double.infinity,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    strokeWidth: 2,
                    color: kPrimaryColor,
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Padding textpart(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 25),
      child: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 18, fontFamily: josefinSansMedium),
      ),
    );
  }
}
