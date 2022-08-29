// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/models/user_models/abous_us_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  bool showText = true;
  final _login = GlobalKey<FormState>();
  late Future<AboutUsModel> getAboutUs;
  @override
  void initState() {
    super.initState();
    getAboutUs = AboutUsModel().getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(
          backArrow: true,
          iconRemove: true,
          elevationWhite: true,
          name: "aboutUs",
          fontSize: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _login,
            child: AnimatedCrossFade(
              crossFadeState: showText ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
              firstChild: page2(),
              secondChild: page1(),
            ),
          ),
        ));
  }

  Widget page1() {
    return FutureBuilder<AboutUsModel>(
        future: getAboutUs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.data == null) {
            return const Center(child: Text("Empty"));
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 8),
                child: Text(
                  "contactInformation".tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                ),
              ),
              simpleButton(icon: IconlyBold.call, name: snapshot.data!.phone!),
              simpleButton(icon: IconlyBold.message, name: snapshot.data!.email!),
              simpleButton(icon: IconlyBold.location, name: Get.locale?.languageCode == "tr" ? snapshot.data!.address_tm! : snapshot.data!.address_ru!),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 15),
                width: Get.size.width,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                  color: backgroundColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: borderRadius20,
                  ),
                  child: Text(
                    "sendText".tr,
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        });
  }

  ListTile simpleButton({required IconData icon, required String name}) {
    return ListTile(
      dense: true,
      onTap: () {},
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
      leading: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget page2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              "contactInformationSubtitle".tr,
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
            requestFocus: emailFocusNode,
            style: false,
          ),
          CustomTextField(
            borderRadius: true,
            labelName: "email",
            controller: emailController,
            focusNode: emailFocusNode,
            requestfocusNode: messageFocusNode,
            isNumber: false,
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
                  AboutUsModel()
                      .sendMessage(
                    phone: phoneController.text,
                    message: messageController.text,
                    email: emailController.text,
                    fullname: nameController.text,
                  )
                      .then((value) {
                    if (value == true) {
                      showSnackBar("Sms gitdowwww", "Sms gitdi", Colors.green);
                    } else {
                      showSnackBar("Bir zada Gote geydin", "Doldur su teext leri", Colors.red);
                    }
                  });
                } else {
                  showSnackBar("Text Doldur", "Doldur su teext leri", Colors.red);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
