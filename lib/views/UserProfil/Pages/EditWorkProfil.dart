// ignore_for_file: file_names, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:io';

import 'package:game_app/constants/index.dart';

class EditWorkProfile extends StatefulWidget {
  const EditWorkProfile({Key? key}) : super(key: key);

  @override
  State<EditWorkProfile> createState() => _EditWorkProfileState();
}

class _EditWorkProfileState extends State<EditWorkProfile> {
  var _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  TextEditingController nameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();

  FocusNode emailFocsNode = FocusNode();

  TextEditingController workController = TextEditingController();

  FocusNode workFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    nameController.text = "Satlyk akkaunt ady";
    phoneController.text = "62 990344";
    emailController.text =
        "Siziň üçin ähli gözellik serişdeleriniň hem-de öýe gerekli bolan himiýa harytlary saýtlar bir ýerde jemlenen. Brendowyý we ýokary hilli gözellik serişdeleri hem-de öýüňiziň arasaçylygy üçin niýetlenen himiýa harytlary gysga wagtyň içinde bu ýerde tapyp bilersiňiz, dowam edýän aksiýalardan we arzanladyşlardan habarly boluň. Hödür etmek bizden, saýlamak sizden";
    workController.text = "Ashgabat";
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
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(color: backgroundColor, borderRadius: borderRadius20),
                      child: ClipRRect(
                          borderRadius: borderRadius20,
                          child: _image != null
                              ? GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: const Icon(
                                    IconlyBold.profile,
                                    size: 45,
                                    color: Colors.black,
                                  ),
                                )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius10),
                            child: const Icon(
                              IconlyLight.edit,
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              textpart("UserName"),
              CustomTextField(labelName: "", controller: nameController, borderRadius: true, focusNode: nameFocusNode, requestfocusNode: phoneFocusNode, isNumber: false),
              textpart("phone"),
              PhoneNumber(
                mineFocus: phoneFocusNode,
                controller: phoneController,
                requestFocus: emailFocsNode,
                style: false,
              ),
              textpart("Description"),
              CustomTextField(labelName: "", controller: emailController, maxline: 8, borderRadius: true, focusNode: emailFocsNode, requestfocusNode: workFocusNode, isNumber: false),
              textpart("selectCity"),
              CustomTextField(labelName: "", controller: workController, borderRadius: true, focusNode: workFocusNode, requestfocusNode: nameFocusNode, isNumber: false),
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
