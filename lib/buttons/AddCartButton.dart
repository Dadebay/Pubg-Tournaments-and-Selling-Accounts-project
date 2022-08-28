// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/walletController.dart';
import 'package:game_app/models/ucModels.dart';

class AddCartButton extends StatefulWidget {
  final bool productProfil;
  final UcModel ucModel;
  const AddCartButton({
    Key? key,
    required this.productProfil,
    required this.ucModel,
  }) : super(key: key);

  @override
  State<AddCartButton> createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  bool value = false;
  int number = 1;
  @override
  void initState() {
    super.initState();
  }

  final WalletController walletController = Get.put(WalletController());
  // addCartFunction() {
  //   for (int i = 0; i < walletController.cartList.length; i++) {
  //     if (walletController.cartList[i]["id"] == widget.ucModel.id) {
  //       walletController.cardIndex.value = i;
  //       number = walletController.cartList[i]["count"];
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryColorBlack, padding: EdgeInsets.symmetric(vertical: widget.productProfil ? 0 : 14, horizontal: value ? 0 : 15), elevation: 0, shape: RoundedRectangleBorder(borderRadius: widget.productProfil ? borderRadius15 : borderRadius20)),
            onPressed: () {
              setState(() {
                if (value == false) {
                  walletController.addCart(ucModel: widget.ucModel);
                  value = !value;
                }
              });
            },
            child: value ? numPart() : textPart()));
    // });
  }

  Widget textPart() {
    return Text(
      "addCart".tr,
      style: TextStyle(color: Colors.white, fontSize: widget.productProfil ? 16 : 22, fontFamily: josefinSansSemiBold),
    );
  }

  Widget numPart() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.productProfil ? 10 : 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                if (number - 1 == 0) {
                  value = false;
                  number = 1;
                  walletController.removeCart(widget.ucModel.id!);
                } else {
                  number--;
                }
                setState(() {});
              },
              child: const Icon(
                CupertinoIcons.minus_circle,
                color: Colors.white,
                size: 24,
              )),
          Text(
            number.toString(),
            style: TextStyle(color: kPrimaryColor, fontSize: widget.productProfil ? 20 : 22, fontFamily: josefinSansBold),
          ),
          GestureDetector(
              onTap: () {
                number++;

                walletController.addCart(ucModel: widget.ucModel);
                setState(() {});
              },
              child: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.white,
                size: 24,
              )),
        ],
      ),
    );
  }
}
