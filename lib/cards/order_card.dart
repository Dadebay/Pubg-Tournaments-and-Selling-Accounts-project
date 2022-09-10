import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';

class OrderCard extends StatelessWidget {
  final int id;
  final int count;
  final String name;
  final String image;
  final String price;
  const OrderCard({
    required this.id,
    required this.count,
    required this.name,
    required this.image,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: borderRadius15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: borderRadius15,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: image,
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
                errorWidget: (context, url, error) => const Text('No Image'),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 17),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<WalletController>().removeCart(id);
                          final double b = double.parse(price);
                          Get.find<WalletController>().finalPRice.value -= b * count;
                          if (Get.find<WalletController>().finalPRice.value == 0) {
                            Get.back();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Icon(
                            CupertinoIcons.xmark_circle,
                            size: 26,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '$price TMT',
                      style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'count'.tr,
                        style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 16),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
