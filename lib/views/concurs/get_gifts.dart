import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/provider/getkonkur.dart';
import 'package:game_app/views/cards/concurs_card.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/views/wallet/order_page.dart';
import 'package:provider/provider.dart';

import '../../../models/user_models/auth_model.dart';

class GetGiftsScreen extends StatefulWidget {
  const GetGiftsScreen({super.key});

  @override
  State<GetGiftsScreen> createState() => _GetGiftsScreenState();
}

class _GetGiftsScreenState extends State<GetGiftsScreen> {
  String dialogTitle = '';
  TextEditingController pubgUserIDController = TextEditingController();
  TextEditingController pubgUserIDController2 = TextEditingController();
  FocusNode pubgUserIDFocusNode = FocusNode();
  FocusNode pubgUserIDFocusNode2 = FocusNode();
  int selectedIndex = 2;
  String title = 'selectUCType'.tr;
  final validator = GlobalKey<FormState>();
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    print('_______________________________');
    fetchData();
    walletController.getUserMoney();
  }

  dynamic fetchData() async {
    await Provider.of<getGiftsProvider>(context, listen: false).getGiftsCart(context);
    await getGiftsProvider().getGiftData().then((value) async {
      if (value == '') {
        dialogTitle = 'enterID'.tr;
      } else {
        dialogTitle = value;
      }
    });
    setState(() {});
  }

  AppBar appBar() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      leadingWidth: 80,
      leading: IconButton(
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [userAppBarMoney()],
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColorBlack,
      title: const Text(
        'Gifts',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
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
                dialogTitle,
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
                  child: Column(
                    children: [
                      CustomTextField(
                        labelName: 'enterIDGift'.tr,
                        controller: pubgUserIDController,
                        borderRadius: true,
                        focusNode: pubgUserIDFocusNode,
                        requestfocusNode: pubgUserIDFocusNode2,
                        isNumber: false,
                      ),
                      CustomTextField(
                        labelName: 'enterIDGift'.tr,
                        controller: pubgUserIDController2,
                        borderRadius: true,
                        focusNode: pubgUserIDFocusNode2,
                        requestfocusNode: pubgUserIDFocusNode,
                        isNumber: false,
                      ),
                    ],
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
                          pubgID: '${pubgUserIDController.text} - ${pubgUserIDController2.text}',
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
      appBar: appBar(),
      body: Column(
        children: [
          customDivider(),
          Expanded(
            child: dialogTitle == ''
                ? spinKit()
                : Consumer<getGiftsProvider>(
                    builder: (_, gifts, __) {
                      return GridView.builder(
                        itemCount: gifts.giftsCart.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8 / 4),
                        itemBuilder: (context, index) {
                          return UCCard2(
                            model: gifts.giftsCart[index],
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
}
