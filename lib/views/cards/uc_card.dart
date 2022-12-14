// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/views/buttons/add_cart_button.dart';
import 'package:game_app/views/constants/index.dart';
import 'package:game_app/views/constants/uc_price.dart';
import 'package:game_app/models/uc_models.dart';

class UCCard extends StatelessWidget {
  final UcModel model;

  const UCCard({
    required this.model,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double a = double.parse(model.price.toString());
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
      decoration: BoxDecoration(
        borderRadius: borderRadius20,
        color: Colors.white.withOpacity(0.9),
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
              child: Price(showDiscountedPrice: false, price: a.toStringAsFixed(1)),
            ),
          ),
          AddCartButton(
            productProfil: false,
            ucModel: model,
          ),
        ],
      ),
    );
  }
}
