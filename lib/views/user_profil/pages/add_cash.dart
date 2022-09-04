// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/constants/price.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/history_order_model.dart';
import 'package:game_app/models/user_models/auth_model.dart';

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
        appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: false, elevationWhite: true, name: "cashHistory"),
        floatingActionButton: addCash
            ? const SizedBox.shrink()
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    addCash = !addCash;
                  });
                },
                style: ElevatedButton.styleFrom(primary: kPrimaryColor, padding: const EdgeInsets.all(15), shape: const RoundedRectangleBorder(borderRadius: borderRadius20)),
                child: Text(
                  "requestCash".tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                ),
              ),
        body: AnimatedCrossFade(firstChild: page2(), secondChild: page1(), crossFadeState: addCash ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: const Duration(milliseconds: 800)));
  }

  FutureBuilder<List<TransactionHistoryModel>> page1() {
    return FutureBuilder<List<TransactionHistoryModel>>(
        future: TransactionHistoryModel().getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return cannotLoadData(
                withButton: true,
                onTap: () {
                  TransactionHistoryModel().getTransactions();
                },
                text: "tournamentInfo14".tr);
          } else if (snapshot.data == null) {
            return cannotLoadData(
                withButton: true,
                onTap: () {
                  TransactionHistoryModel().getTransactions();
                },
                text: "tournamentInfo14".tr);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              double a = double.parse(snapshot.data![index].count.toString());
              return ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "cash".tr + " ${index + 1}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      snapshot.data![index].created_date!.substring(0, 10),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontFamily: josefinSansRegular),
                    )),
                    Expanded(child: Price(showDiscountedPrice: true, price: a.toStringAsFixed(0))),
                  ],
                ),
                iconColor: Colors.white,
              );
            },
          );
        });
  }

  Widget page2() {
    return Form(
      key: _login,
      child: ListView(
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
              onTap: () async {
                final token = await Auth().getToken();
                if (_login.currentState!.validate()) {
                  if (token != null) {
                    Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;

                    TransactionHistoryModel()
                        .requestCash(
                      phone: phoneController.text,
                      message: messageController.text,
                      fullname: nameController.text,
                    )
                        .then((value) {
                      if (value == 200) {
                        Get.back();

                        showSnackBar("copySucces", "smsSuccesfullySent", Colors.green);
                        phoneController.clear();
                        messageController.clear();
                        nameController.clear();
                      } else {
                        showSnackBar("noConnection3", "tournamentInfo14", Colors.red);
                      }
                      Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                    });
                  } else {
                    showSnackBar("loginError", "loginError1", Colors.red);
                  }
                } else {
                  showSnackBar("tournamentInfo14", "errorEmpty", Colors.red);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
