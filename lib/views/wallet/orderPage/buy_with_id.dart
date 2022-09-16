import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';
import 'package:game_app/models/user_models/auth_model.dart';

import '../../../constants/index.dart';

class BuyWithID extends StatefulWidget {
  const BuyWithID({Key? key}) : super(key: key);

  @override
  State<BuyWithID> createState() => _BuyWithIDState();
}

class _BuyWithIDState extends State<BuyWithID> {
  TextEditingController pubgUserIDController = TextEditingController();
  final WalletController walletController = Get.put(WalletController());

  FocusNode pubgUserIDFocusNode = FocusNode();

  String title = 'selectUCType'.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(fontSize: 0.0, backArrow: true, iconRemove: true, name: 'orderType2'.tr, elevationWhite: true),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  child: Text(
                    'enterID'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansSemiBold),
                  ),
                ),
                CustomTextField(
                  labelName: 'accountDetaile2'.replaceAll(RegExp(r':'), ''),
                  controller: pubgUserIDController,
                  focusNode: pubgUserIDFocusNode,
                  requestfocusNode: pubgUserIDFocusNode,
                  isNumber: false,
                  borderRadius: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 15, left: 10),
                  child: Text(
                    'selectUCType'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansSemiBold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    selectUcTypeDialog(context);
                  },
                  title: Text(
                    title,
                    style: TextStyle(color: title == 'selectUCType' ? Colors.grey : Colors.white, fontSize: 16, fontFamily: josefinSansRegular),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius: borderRadius20, side: BorderSide(color: Colors.white, width: 2)),
                  trailing: const Icon(IconlyLight.arrowDownCircle, color: Colors.white),
                )
              ],
            ),
          ),
          bottomPart()
        ],
      ),
    );
  }

  Future selectUcTypeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.grey.withOpacity(0.2),
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: kPrimaryColorBlack,
                borderRadius: borderRadius15,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    child: Text(
                      'selectUCType'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: kPrimaryColor, fontSize: 26, fontFamily: josefinSansSemiBold),
                    ),
                  ),
                  FutureBuilder<List<UcModel>>(
                    future: UcModel().getUCS(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: spinKit());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else if (snapshot.data == null) {
                        return const Center(
                          child: Text('Null'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return UcCard(
                            snapshot,
                            index,
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector UcCard(
    AsyncSnapshot<List<UcModel>> snapshot,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        title = snapshot.data![index].title!;
        walletController.finalPRice.value = double.parse(snapshot.data![index].price!);
        walletController.cartList.clear();
        walletController.addCart(ucModel: snapshot.data![index]);
        setState(() {});
        Get.back();
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: borderRadius10,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                snapshot.data![index].title!,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontFamily: josefinSansMedium, fontSize: 17),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Text(
                snapshot.data![index].price!.substring(0, snapshot.data![index].price!.length - 1) + ' TMT',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.end,
                style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomPart() {
    return Container(
      color: kPrimaryColorBlack,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'info'.tr,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'orderPage3'.tr,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 18),
                ),
                Obx(() {
                  return Text(
                    '${walletController.finalPRice} TMT',
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansMedium, fontSize: 20),
                  );
                }),
              ],
            ),
          ),
          Center(
            child: AgreeButton(
              onTap: () async {
                final token = await Auth().getToken();
                if (token != null) {
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                  final List list = [];
                  for (var element in walletController.cartList) {
                    list.add({
                      'uc': element['id'],
                      'count': element['count'],
                    });
                  }
                  await UcModel().addCart(list, true, pubgUserIDController.text).then((value) {
                    if (value == 200) {
                      walletController.cartList.clear();
                      walletController.cartList.refresh();
                      Get.back();
                      showSnackBar('copySucces', 'orderSubtitle', Colors.green);
                    } else if (value == 404) {
                      showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                    } else {
                      showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                    }
                  });
                  Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
                } else {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
