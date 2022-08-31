// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:game_app/constants/index.dart';

import 'package:dotted_border/dotted_border.dart';
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
  const AddPage({Key? key, required this.locationID, required this.pubgType}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController bioController = TextEditingController();

  FocusNode bioFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

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
      print("error: $error");
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: "enterSurname", controller: lastNameController, focusNode: lastNameFocusNode, requestfocusNode: emailFocusNode, isNumber: false, borderRadius: true),
              ),
              CustomTextField(labelName: "email", controller: emailController, focusNode: emailFocusNode, requestfocusNode: bioFocusNode, isNumber: false, borderRadius: true),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(labelName: "accountPrice", controller: priceController, focusNode: priceFocusNode, requestfocusNode: userNameFocusNode, isNumber: true, borderRadius: true),
              ),
              CustomTextField(
                labelName: "add_page1",
                controller: bioController,
                focusNode: bioFocusNode,
                requestfocusNode: priceFocusNode,
                isNumber: false,
                borderRadius: true,
                maxline: 6,
              ),
              selectedImage != null
                  ? GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(borderRadius: borderRadius10),
                        child: Material(
                          elevation: 2,
                          borderRadius: borderRadius10,
                          child: ClipRRect(
                            borderRadius: borderRadius10,
                            child: Image.file(selectedImage!, fit: BoxFit.cover),
                          ),
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
                          margin: const EdgeInsets.all(10),
                          width: 80,
                          height: 80,
                          child: DottedBorder(
                            borderType: BorderType.Oval,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(6),
                            strokeWidth: 2,
                            color: kPrimaryColor,
                            child: const Center(child: Text("Profil Surat Saylan")),
                          ),
                        ),
                      ),
                    ),
              selectedImage1 != null
                  ? GestureDetector(
                      onTap: () {
                        pickImage1();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(borderRadius: borderRadius10),
                        child: Material(
                          elevation: 2,
                          borderRadius: borderRadius10,
                          child: ClipRRect(
                            borderRadius: borderRadius10,
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
                        margin: const EdgeInsets.all(10),
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
              RaisedButton(onPressed: () async {
                final token = await Auth().getToken();
                Get.to(() => const Page4());
                print(token);
              }),
              AgreeButton(onTap: () async {
                final token = await Auth().getToken();
                var headers = {'Authorization': 'Bearer $token'};
                var request = http.MultipartRequest('POST', Uri.parse('$serverURL/api/accounts/update-account/'));
                request.fields.addAll({
                  'pubg_username': userNameController.text,
                  'pubg_id': pubgIDController.text,
                  'first_name': fisrtNameController.text,
                  'last_name': 'asdasd',
                  'email': 'asdasd',
                  'bio': 'qwdqwdq',
                  'location': '${widget.locationID}',
                  'pubg_type': '${widget.pubgType}',
                  'for_sale': '1',
                  'price': '1500'
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

                if (response.statusCode == 200) {
                  print(await response.stream.bytesToString());
                } else {
                  print(response.reasonPhrase);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
