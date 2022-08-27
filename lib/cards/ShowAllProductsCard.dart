// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_app/constants/Price.dart';
import 'package:game_app/constants/constants.dart';
import 'package:game_app/constants/widgets.dart';
import 'package:game_app/models/AccountsForSaleModel.dart';
import 'package:game_app/views/OtherPages/AccountProfilPage.dart';
import 'package:get/get.dart';

import '../buttons/favButton.dart';

class ShowAllProductsCard extends StatelessWidget {
  final AccountsForSaleModel model;
  final bool fav;
  const ShowAllProductsCard({Key? key, required this.fav, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AccountProfilPage(
              userID: model.user!,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: model.vip == true ? kPrimaryColor : Colors.grey.withOpacity(0.4),
            gradient: model.vip == true ? LinearGradient(colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.3)], stops: const [0, 0.99], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
            borderRadius: borderRadius15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 5,
                child: SizedBox(
                  width: Get.size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: borderRadius15,
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
                              errorWidget: (context, url, error) => Container(
                                    color: Colors.white.withOpacity(0.2),
                                    child: Center(
                                        child: Text(
                                      "noImage".tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                                    )),
                                  )),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: FavButton(
                            model: model,
                          )),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 6, top: 6),
                  width: Get.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        model.nickname.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: josefinSansSemiBold,
                        ),
                      ),
                      Text(
                        model.createdDate.toString().substring(0, 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontFamily: josefinSansRegular, fontSize: 16),
                      ),
                      Price(showDiscountedPrice: false, price: model.price.toString().substring(0, model.price!.length - 3)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
