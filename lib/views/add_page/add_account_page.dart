// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:game_app/constants/index.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'video_upload_page.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class AddPage extends StatefulWidget {
  final int locationID;
  final int pubgType;
  final int vipOrNot;
  const AddPage({Key? key, required this.locationID, required this.pubgType, required this.vipOrNot}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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

  File? selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage = imageTemporary;
      });
    } catch (error) {
      showSnackBar("noConnection3", "$error", Colors.red);
    }
  }

  File? selectedImage1;

  Future pickImage1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage1 = imageTemporary;
      });
    } catch (error) {
      showSnackBar("noConnection3", "$error", Colors.red);
    }
  }

  final _addAccount = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(fontSize: 20, backArrow: true, iconRemove: false, name: "add_page", elevationWhite: true),
      body: Form(
        key: _addAccount,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "addAccount1".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                ),
              ),
              CustomTextField(labelName: "signIn1", controller: userNameController, focusNode: userNameFocusNode, requestfocusNode: pubgIDFocusNode, isNumber: false, borderRadius: true),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: "signIn2", controller: pubgIDController, focusNode: pubgIDFocusNode, requestfocusNode: firstNameFocusNode, isNumber: false, borderRadius: true),
              ),
              CustomTextField(labelName: "enterUserName", controller: fisrtNameController, focusNode: firstNameFocusNode, requestfocusNode: lastNameFocusNode, isNumber: false, borderRadius: true),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomTextField(labelName: "enterSurname", controller: lastNameController, focusNode: lastNameFocusNode, requestfocusNode: priceFocusNode, isNumber: false, borderRadius: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: "accountPrice", controller: priceController, focusNode: priceFocusNode, requestfocusNode: bioFocusNode, isNumber: true, borderRadius: true),
              ),
              CustomTextField(
                labelName: "add_page1",
                controller: bioController,
                focusNode: bioFocusNode,
                requestfocusNode: userNameFocusNode,
                isNumber: false,
                borderRadius: true,
                maxline: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  "select_user_image".tr,
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
                        pickImage();
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
                            )),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
                child: Text(
                  "select_user_bg_image".tr,
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
                        pickImage1();
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
              AgreeButton(onTap: () {
                Get.to(() => const VideoUploadPage());
              }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AgreeButton(onTap: () async {
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                  final token = await Auth().getToken();
                  var headers = {'Authorization': 'Bearer $token'};
                  var request = http.MultipartRequest('POST', Uri.parse('$serverURL/api/accounts/update-account/'));
                  request.fields.addAll({
                    'pubg_username': userNameController.text,
                    'pubg_id': pubgIDController.text,
                    'first_name': fisrtNameController.text,
                    'last_name': lastNameController.text,
                    'email': "",
                    'bio': bioController.text,
                    'location': '${widget.locationID}',
                    'pubg_type': '${widget.pubgType}',
                    'for_sale': '1',
                    "vip": "${widget.vipOrNot}",
                    'price': priceController.text
                  });
                  request.headers.addAll(headers);

                  final String fileName = selectedImage!.path.split("/").last;
                  final stream = http.ByteStream(DelegatingStream.typed(selectedImage!.openRead()));
                  final length = await selectedImage!.length();
                  final mimeTypeData = lookupMimeType(selectedImage!.path, headerBytes: [0xFF, 0xD8])!.split('/');
                  final multipartFileSign = http.MultipartFile('image', stream, length, filename: fileName, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
                  request.files.add(multipartFileSign);

                  final String fileName1 = selectedImage1!.path.split("/").last;
                  final stream1 = http.ByteStream(DelegatingStream.typed(selectedImage1!.openRead()));
                  final length1 = await selectedImage1!.length();
                  final mimeTypeData1 = lookupMimeType(selectedImage1!.path, headerBytes: [0xFF, 0xD8])!.split('/');
                  final multipartFileSign1 = http.MultipartFile('bg_image', stream1, length1, filename: fileName1, contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));
                  request.files.add(multipartFileSign1);

                  http.StreamedResponse response = await request.send();
                  print(response.statusCode);
                  print(response.reasonPhrase);
                  print(response.isRedirect);
                  if (response.statusCode == 200) {
                    Get.to(() => const VideoUploadPage());
                    Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                  } else {
                    showSnackBar("noConnection3", "tournamentInfo14", Colors.red);
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
