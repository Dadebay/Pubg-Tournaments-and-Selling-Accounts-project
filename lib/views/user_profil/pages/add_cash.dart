// ignore_for_file: file_names

import 'package:game_app/constants/index.dart';
import 'package:game_app/constants/price.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/history_order_model.dart';
import 'package:game_app/models/user_models/auth_model.dart';

class AddCash extends StatefulWidget {
  final String phoneNumber;
  const AddCash({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<AddCash> createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  bool addCash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: false, elevationWhite: true, name: 'cashHistory'),
      body: Column(
        children: [
          Expanded(child: page1()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => AskMoneyPage(
                            phoneNumber: widget.phoneNumber,
                            text: 'message1',
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, padding: const EdgeInsets.all(15), shape: const RoundedRectangleBorder(borderRadius: borderRadius20)),
                      child: Text(
                        'requestCash1'.tr,
                        style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => AskMoneyPage(
                          phoneNumber: widget.phoneNumber,
                          text: 'message',
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, padding: const EdgeInsets.all(15), shape: const RoundedRectangleBorder(borderRadius: borderRadius20)),
                    child: Text(
                      'requestCash'.tr,
                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
            text: 'tournamentInfo14'.tr,
          );
        } else if (snapshot.data == null) {
          return cannotLoadData(
            withButton: true,
            onTap: () {
              TransactionHistoryModel().getTransactions();
            },
            text: 'tournamentInfo14'.tr,
          );
        } else if (snapshot.data.toString() == '[]') {
          return cannotLoadData(
            withButton: true,
            onTap: () {
              TransactionHistoryModel().getTransactions();
            },
            text: 'tournamentInfo14'.tr,
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final double a = double.parse(snapshot.data![index].count.toString());
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'cash'.tr + ' ${snapshot.data!.length - index}',
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
                    ),
                  ),
                  Expanded(child: Price(showDiscountedPrice: true, price: a.toStringAsFixed(0))),
                ],
              ),
              iconColor: Colors.white,
            );
          },
        );
      },
    );
  }
}

class AskMoneyPage extends StatefulWidget {
  final String phoneNumber;
  final String text;
  const AskMoneyPage({
    required this.text,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<AskMoneyPage> createState() => _AskMoneyPageState();
}

class _AskMoneyPageState extends State<AskMoneyPage> {
  TextEditingController messageController = TextEditingController();

  FocusNode messageFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();

  final _login = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    phoneController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: false, elevationWhite: true, name: 'cashHistory'),
      body: Form(
        key: _login,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'addCash'.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 18),
              ),
            ),
            CustomTextField(
              labelName: 'fullName',
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
              disabled: false,
            ),
            CustomTextField(
              maxline: 4,
              borderRadius: true,
              labelName: widget.text,
              controller: messageController,
              focusNode: messageFocusNode,
              requestfocusNode: nameFocusNode,
              isNumber: false,
              isLabel: true,
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

                      await TransactionHistoryModel()
                          .requestCash(
                        phone: phoneController.text,
                        message: messageController.text,
                        fullname: nameController.text,
                      )
                          .then((value) {
                        if (value == 200) {
                          Get.back();

                          showSnackBar('copySucces', 'smsSuccesfullySent', Colors.green);
                          phoneController.clear();
                          messageController.clear();
                          nameController.clear();
                        } else {
                          showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                        }
                        Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                      });
                    } else {
                      showSnackBar('loginError', 'loginError1', Colors.red);
                    }
                  } else {
                    showSnackBar('tournamentInfo14', 'errorEmpty', Colors.red);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
