// ignore_for_file: file_names

import 'dart:ui';

import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';

class FavButton extends StatefulWidget {
  const FavButton({Key? key, this.color, required this.model}) : super(key: key);
  final bool? color;
  final AccountsForSaleModel model;
  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool bookmarkIcon = false;
  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().favList.forEach((element) {
      if (element["id"] == widget.model.id) {
        bookmarkIcon = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bookmarkIcon = !bookmarkIcon;
          if (bookmarkIcon == true) {
            Get.find<WalletController>().addFavList(id: widget.model.id!, price: widget.model.price ?? "", name: widget.model.nickname ?? "noNome".tr, image: widget.model.image ?? "", pubID: widget.model.pubgId ?? "");
          } else {
            Get.find<WalletController>().removeFav(widget.model.id!);
          }
        });
      },
      child: widget.color == false
          ? Container(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Icon(bookmarkIcon ? IconlyBold.heart : IconlyLight.heart, size: 28, color: bookmarkIcon ? kPrimaryColor : Colors.white),
            )
          : ClipRRect(
              borderRadius: borderRadius15,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: borderRadius15),
                  child: Icon(bookmarkIcon ? IconlyBold.heart : IconlyLight.heart, color: bookmarkIcon ? Colors.red : Colors.black),
                ),
              ),
            ),
    );
  }
}
