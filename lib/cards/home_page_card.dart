// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/buttons/fav_button.dart';
import 'package:game_app/constants/price.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';
import 'package:game_app/views/other_pages/account_profil_page/account_profil_page.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({Key? key, required this.vip, required this.model}) : super(key: key);
  final bool vip;
  final AccountsForSaleModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AccountProfilPage(
              userID: model.user!,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: vip ? kPrimaryColorBlack1 : kPrimaryColorBlack1.withOpacity(0.1),
            gradient: vip ? LinearGradient(colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.1)], stops: const [0, 0.9], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
            border: Border.all(color: kPrimaryColor.withOpacity(0.6)),
            borderRadius: borderRadius15),
        height: 170,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: borderRadius15,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                            fadeInCurve: Curves.ease,
                            imageUrl: "$serverURL${model.image}",
                            imageBuilder: (context, imageProvider) => Container(
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius15,
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
                                    "noImageBanner".tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                                  )),
                                )),
                      ),
                      // Positioned(  VIP BADGE BOLMALY
                      //   top: 8,
                      //   left: -35,
                      //   child: vip
                      //       ? Transform.rotate(
                      //           angle: pi / -4.5,
                      //           child: Container(
                      //             color: Colors.black,
                      //             width: 120,
                      //             padding: const EdgeInsets.symmetric(vertical: 4),
                      //             child: const Center(
                      //               child: Text(
                      //                 "VIP",
                      //                 style: TextStyle(color: kPrimaryColor, fontSize: 18, fontFamily: josefinSansSemiBold),
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //       : const SizedBox.shrink(),
                      // )
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.nickname!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: vip ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontFamily: josefinSansBold,
                            ),
                          ),
                          FavButton(
                            model: model,
                            color: false,
                          )
                        ],
                      ),
                      Text(
                        model.pubgId!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: vip ? Colors.black87 : Colors.white70, fontFamily: josefinSansRegular, fontSize: 17),
                      ),
                      Price(
                        price: model.price!.substring(0, model.price!.length - 3),
                        showDiscountedPrice: false,
                      ),
                      Text(model.createdDate!.substring(0, 10),
                          style: TextStyle(
                            color: vip ? Colors.black87 : Colors.white70,
                            fontSize: 16,
                            fontFamily: josefinSansRegular,
                          )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
