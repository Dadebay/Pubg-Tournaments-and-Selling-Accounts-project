import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';

import '../../../models/user_models/auth_model.dart';
import '../cards/uc_card.dart';
import '../constants/index.dart';
import 'order_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController pubgUserIDController = TextEditingController();
  final WalletController walletController = Get.put(WalletController());
  FocusNode pubgUserIDFocusNode = FocusNode();

  String title = 'selectUCType'.tr;
  final validator = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().getUserMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      floatingActionButton: Obx(() {
        return AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: orderButton(),
          crossFadeState: walletController.cartList.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          sizeCurve: Curves.easeInOut,
        );
      }),
      appBar: appBAr(),
      body: Column(
        children: [
          customDivider(),
          Expanded(
            child: FutureBuilder<List<UcModel>>(
              future: UcModel().getUCS(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.data == []) {
                  return const Center(child: Text('Empty'));
                }
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4),
                  itemBuilder: (context, index) {
                    return UCCard(
                      model: snapshot.data![index],
                      selectedIndex: selectedIndex,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBAr() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      leadingWidth: 80,
      // leading: GestureDetector(
      //   onTap: () {
      //     selectCurrency();
      //   },
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 8, right: 8),
      //         child: ClipOval(
      //           child: Image.asset(
      //             selectedIndex == 1
      //                 ? ruIcon
      //                 : selectedIndex == 2
      //                     ? tmIcon
      //                     : trIcon,
      //             width: 30,
      //             height: 30,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       Text(
      //         selectedIndex == 1
      //             ? 'Rub'
      //             : selectedIndex == 2
      //                 ? 'TMT'
      //                 : 'TL',
      //         style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
      //       )
      //     ],
      //   ),
      // ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: userAppBarMoney(),
        )
      ],
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColorBlack,
      title: Text(
        'Pubg UC'.tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: josefinSansSemiBold,
          fontSize: 25,
        ),
      ),
    );
  }

  ElevatedButton orderButton() {
    return ElevatedButton(
      onPressed: () async {
        final token = await Auth().getToken();
        if (token == null || token == '') {
          showSnackBar('loginError', 'loginError1', Colors.red);
        } else {
          await onTapFunction();
        }
      },
      style: ElevatedButton.styleFrom(elevation: 1, backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius15), padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'order'.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 8),
            child: Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }

  onTapFunction() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColorBlack,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius20, side: BorderSide(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'enterID'.tr,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(key: validator, child: CustomTextField(labelName: 'Pubg id:', controller: pubgUserIDController, borderRadius: true, focusNode: pubgUserIDFocusNode, requestfocusNode: pubgUserIDFocusNode, isNumber: false)),
              ),
              AgreeButton(
                name: 'agree',
                onTap: () async {
                  final token = await Auth().getToken();
                  if (token != null) {
                    if (validator.currentState!.validate()) {
                      double value = 0.0;
                      double counts = 0.0;
                      for (var element in walletController.cartList) {
                        value += double.parse(element['price']) * element['count'];
                        counts += element['count'];
                      }
                      walletController.finalPRice.value = value;
                      walletController.finalCount.value = counts;
                      await Get.to(
                        () => OrderPage(
                          pubgID: pubgUserIDController.text,
                        ),
                      );
                    } else {
                      showSnackBar('tournamentInfo14', 'errorEmpty', Colors.red);
                    }
                  } else {
                    showSnackBar('noConnection3', 'order_error_subtitle', Colors.red);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  int selectedIndex = 2;
  Future<Object?> selectCurrency() {
    return showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.decelerate.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 400, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: kPrimaryColorBlack,
              shape: const OutlineInputBorder(borderRadius: borderRadius15, borderSide: BorderSide(color: Colors.white)),
              title: Text(
                'cash'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontFamily: josefinSansBold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 6, right: 6),
                    child: Text(
                      'selectCurrencyType'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: josefinSansSemiBold),
                    ),
                  ),
                  flagButton(ruIcon, 'RUB', 1),
                  flagButton(tmIcon, 'TMT', 2),
                  flagButton(trIcon, 'TL  ', 3),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }

  GestureDetector flagButton(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        selectedIndex = index;
        setState(() {});
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            ClipOval(
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
