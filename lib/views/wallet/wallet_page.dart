import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/uc_models.dart';

import '../../../models/user_models/auth_model.dart';
import '../cards/wallet_card.dart';
import '../constants/index.dart';
import 'order_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

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
    walletController.getUserMoney();
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
                    return WalletCard(
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: userAppBarMoney(),
        ),
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
        if (await _checkToken()) {
          await onTapFunction();
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'order'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: josefinSansSemiBold,
              fontSize: 22,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 8),
            child: Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkToken() async {
    final token = await Auth().getToken();
    if (token == null || token.isEmpty) {
      showSnackBar('loginError', 'loginError1', Colors.red);
      return false;
    }
    return true;
  }

  Future<void> onTapFunction() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColorBlack,
          shape: const RoundedRectangleBorder(
            borderRadius: borderRadius20,
            side: BorderSide(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'enterID'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: josefinSansBold,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: validator,
                  child: CustomTextField(
                    labelName: 'Pubg id:',
                    controller: pubgUserIDController,
                    borderRadius: true,
                    focusNode: pubgUserIDFocusNode,
                    requestfocusNode: pubgUserIDFocusNode,
                    isNumber: false,
                  ),
                ),
              ),
              AgreeButton(
                name: 'agree',
                onTap: () async {
                  if (await _checkToken()) {
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
                          onlyCard: false,
                          asking: 'accountDetaile2'.tr,
                        ),
                      );
                    } else {
                      showSnackBar('tournamentInfo14', 'errorEmpty', Colors.red);
                    }
                  } else {
                    showSnackBar('noConnection3', 'order_error_subtitle', Colors.red);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  int selectedIndex = 2;
}
