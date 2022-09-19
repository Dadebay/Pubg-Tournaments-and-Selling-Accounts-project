// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/buttons/add_cart_button.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/constants/uc_price.dart';
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
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
      decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.white.withOpacity(0.9), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, spreadRadius: 3)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: borderRadius20,
              child: Hero(
                tag: '$serverURL${model.image}',
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
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontFamily: josefinSansSemiBold, fontSize: 18),
                  ),
                  Price(showDiscountedPrice: false, price: a.toStringAsFixed(1))
                ],
              ),
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
