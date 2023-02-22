import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_app/app/constants/others/constants.dart';
import 'package:game_app/app/modules/others/player_profile.dart';
import 'package:get/get.dart';

import '../others/widgets.dart';

class BestPlayersCard extends StatelessWidget {
  final String points;
  final String name;
  final String image;
  final int index;
  final bool referalPage;
  const BestPlayersCard({super.key, required this.name, required this.image, required this.index, required this.points, required this.referalPage});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () {
        Get.to(() => const PlayerProfil());
      },
      dense: true,
      tileColor: index % 2 == 0 ? kPrimaryColorBlack1 : kPrimaryColorBlack,
      minVerticalPadding: 15,
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(
              ' ${index + 1}.',
              textAlign: referalPage ? TextAlign.center : TextAlign.start,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
            ),
          ),
          referalPage
              ? const SizedBox.shrink()
              : Expanded(
                  flex: 3,
                  child: ClipOval(
                    child: SizedBox(
                      width: 60,
                      height: 70,
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.ease,
                        imageUrl: image,
                        imageBuilder: (context, imageProvider) => Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: spinKit()),
                        errorWidget: (context, url, error) => Container(
                          color: kPrimaryColor.withOpacity(0.2),
                          child: Center(
                            child: Text(
                              'noImage'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Expanded(
            flex: 10,
            child: Text(
              '  $name',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
            ),
          ),
          Expanded(
            flex: 4,
            child: referalPage
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        points,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: josefinSansSemiBold,
                        ),
                      ),
                      const Text(
                        ' TMT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: josefinSansSemiBold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    points,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
