// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';
import 'package:game_app/views/other_pages/account_profil_page/account_profil_page.dart';

import '../constants/index.dart';
import '../constants/uc_price.dart';

class HomePageCard extends StatelessWidget {
  final bool vip;
  final AccountsForSaleModel model;
  const HomePageCard({
    required this.vip,
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Get.to(
          () => AccountProfilPage(
            userID: model.user!,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: size.width >= 800 ? 0 : 10,
          horizontal: size.width >= 800 ? 10 : 20,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: vip ? kPrimaryColorBlack1 : kPrimaryColorBlack1.withOpacity(0.1),
          gradient: vip ? LinearGradient(colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.1)], stops: const [0, 0.9], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
          border: Border.all(color: kPrimaryColor.withOpacity(0.6)),
          borderRadius: borderRadius15,
        ),
        height: 170,
        child: size.width >= 800
            ? Column(
                children: [imagePart(size), textPart(size)],
              )
            : Row(
                children: [imagePart(size), textPart(size)],
              ),
      ),
    );
  }

  Expanded textPart(Size size) {
    return Expanded(
      flex: size.width >= 800 ? 1 : 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              model.nickname!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: vip ? Colors.black : Colors.white,
                fontSize: size.width >= 800 ? 27 : 20,
                fontFamily: josefinSansBold,
              ),
            ),
            Text(
              model.pubgId!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: vip ? Colors.black87 : Colors.white70, fontFamily: josefinSansRegular, fontSize: size.width >= 800 ? 22 : 17),
            ),
            Price(
              price: model.price!.substring(0, model.price!.length - 3),
              showDiscountedPrice: false,
            ),
            size.width >= 800
                ? const SizedBox.shrink()
                : Text(
                    model.createdDate!.substring(0, 10),
                    style: TextStyle(
                      color: vip ? Colors.black87 : Colors.white70,
                      fontSize: size.width >= 800 ? 22 : 16,
                      fontFamily: josefinSansRegular,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Expanded imagePart(Size size) {
    return Expanded(
      flex: size.width >= 800 ? 2 : 1,
      child: ClipRRect(
        borderRadius: borderRadius15,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: '$serverURL${model.image}',
                imageBuilder: (context, imageProvider) => Container(
                  width: Get.size.width,
                  margin: EdgeInsets.all(
                    size.width >= 800 ? 8 : 0,
                  ),
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
                      'noImageBanner'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
