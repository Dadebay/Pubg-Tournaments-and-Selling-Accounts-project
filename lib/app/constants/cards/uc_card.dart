// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/app/constants/packages/index.dart';
import 'package:game_app/app/data/models/uc_view_models/uc_card_model.dart';
import 'package:get/get.dart';

import '../buttons/add_cart_button.dart';
import '../others/price.dart';
import '../others/widgets.dart';

class UCCard extends StatelessWidget {
  final UcCardModel model;
  final int selectedIndex;
  const UCCard({
    required this.model,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double a = 0.0;
    if (selectedIndex == 1) {
      a = double.parse(model.rublePrice.toString());
    } else if (selectedIndex == 2) {
      a = double.parse(model.price.toString());
    } else if (selectedIndex == 3) {
      a = double.parse(model.liraPrice.toString());
    }
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
      decoration: BoxDecoration(
        borderRadius: borderRadius25,
        color: Colors.white.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: borderRadius25,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: '$serverURL${model.image}',
                imageBuilder: (context, imageProvider) => Container(
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius25,
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
              child: Price(showDiscountedPrice: false, selectedIndex: selectedIndex, price: a.toStringAsFixed(1)),
            ),
          ),
          AddCartButton(
            productProfil: false,
            id: model.id!,
            price: model.price!,
            image: model.image!,
            title: model.title!,
          ),
        ],
      ),
    );
  }
}
