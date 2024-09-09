// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/models/get_gifts_model.dart';
import 'package:game_app/views/buttons/add_cart_button.dart';
import 'package:game_app/views/constants/index.dart';

import '../constants/price.dart';

class UCCard2 extends StatelessWidget {
  final GiftsMOdel model;
  final int selectedIndex;
  const UCCard2({
    required this.model,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double a = 0.0;

    // if (selectedIndex == 1) {
    //   a = double.parse(model.rublePrice.toString());
    // } else if (selectedIndex == 2) {
    //   a = double.parse(model.price.toString());
    // } else if (selectedIndex == 3) {
    //   a = double.parse(model.liraPrice.toString());
    // }
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
      decoration: BoxDecoration(
        borderRadius: borderRadius20,
        color: kPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: borderRadius20,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: '$serverURL${model.image}',
                imageBuilder: (context, imageProvider) => Container(
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius20,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: spinKit()),
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    'noImage'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: josefinSansSemiBold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 6),
              child: Price(showDiscountedPrice: false, textColor: Colors.black, selectedIndex: selectedIndex, price: a.toStringAsFixed(1)),
            ),
          ),
          AddCartButton(
            productProfil: false,
            id: model.id,
            price: model.price.toString(),
            image: model.image,
            title: model.nameTm,
          ),
        ],
      ),
    );
  }
}
