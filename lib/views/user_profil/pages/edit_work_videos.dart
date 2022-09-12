import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app/constants/app_bar.dart';
import 'package:game_app/constants/constants.dart';
import 'package:game_app/constants/widgets.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';
import 'package:get/get.dart';

class EditWorkVideos extends StatelessWidget {
  final int userId;

  const EditWorkVideos({
    required this.userId,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(backArrow: true, fontSize: 0.0, iconRemove: true, elevationWhite: true, name: 'editVideo'),
      body: FutureBuilder<List<GetAccountVideos>>(
        future: GetAccountVideos().getVideos(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'account_profil_not_video'.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'account_profil_not_video'.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: borderRadius15,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.ease,
                        imageUrl: '$serverURL${snapshot.data![index].poster}',
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
                              'noImageBanner'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 5,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.xmark_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              );

              // VideoCard(
              //   image: "$serverURL${snapshot.data![index].poster}",
              //   videoPath: "$serverURL${snapshot.data![index].video}",
              // );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
        },
      ),
    );
  }
}
