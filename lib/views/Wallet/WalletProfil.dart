// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/buttons/AddCartButton.dart';
import 'package:game_app/constants/price.dart';
import 'package:game_app/constants/index.dart';

import '../../models/ucModels.dart';

class WalletProfil extends StatelessWidget {
  final UcModel model;
  const WalletProfil({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      extendBody: true,
      appBar: MyAppBar(
          fontSize: 22,
          backArrow: true,
          icon: IconButton(
            icon: const Icon(IconlyLight.arrowLeftCircle, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          iconRemove: true,
          name: model.title!,
          elevationWhite: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagepart(),
            textPart(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: AddCartButton(
                productProfil: false,
                ucModel: model,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding textPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.title!,
            maxLines: 3,
            style: const TextStyle(color: Colors.black, fontFamily: josefinSansSemiBold, fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 14),
            child: Row(
              children: [
                Text(
                  "price".tr,
                  style: const TextStyle(color: Colors.black, fontFamily: josefinSansMedium, fontSize: 20),
                ),
                Price(showDiscountedPrice: false, price: model.price.toString())
              ],
            ),
          ),
          Text(
            "info".tr,
            style: const TextStyle(color: Colors.black, fontFamily: josefinSansMedium, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              model.description_tm!,
              style: const TextStyle(color: Colors.grey, fontFamily: josefinSansRegular, height: 1.5, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox imagepart() {
    return SizedBox(
      width: Get.size.width,
      height: Get.size.height / 2.4,
      child: Hero(
        tag: "$serverURL${model.image}",
        child: ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: CachedNetworkImage(
              fadeInCurve: Curves.ease,
              imageUrl: "$serverURL${model.image}",
              imageBuilder: (context, imageProvider) => Container(
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
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
    );
  }
}


// 146.19.196.163
// 95.174.68.161
// 88.210.37.45