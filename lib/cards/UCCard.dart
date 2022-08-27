// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/buttons/AddCartButton.dart';
import 'package:game_app/constants/Price.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/UcModels.dart';
import 'package:game_app/views/Wallet/WalletProfil.dart';

class UCCard extends StatelessWidget {
  const UCCard({Key? key, required this.model}) : super(key: key);
  final UcModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WalletProfil(
              model: model,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
        decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.white.withOpacity(0.9), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, spreadRadius: 3)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: borderRadius20,
                child: Hero(
                  tag: "$serverURL${model.image}",
                  child: CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: "$serverURL${model.image}",
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
                      errorWidget: (context, url, error) => const Text("No Image")),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 6),
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
                    Price(showDiscountedPrice: false, price: model.price.toString())
                  ],
                ),
              ),
            ),
            AddCartButton(
              productProfil: true,
              ucModel: model,
            ),
          ],
        ),
      ),
    );
  }
}
