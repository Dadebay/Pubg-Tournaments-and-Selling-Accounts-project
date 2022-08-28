// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournamentModel.dart';

class TabPage3 extends StatelessWidget {
  const TabPage3({Key? key, required this.model}) : super(key: key);
  final TournamentModel model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.participated_users!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {},
            tileColor: index % 2 == 0 ? kPrimaryColorBlack : kPrimaryColorBlack1,
            minVerticalPadding: 15,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}.",
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: "$serverURL${model.participated_users![index].userImage}",
                      imageBuilder: (context, imageProvider) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kPrimaryColor),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      placeholder: (context, url) => Center(child: spinKit()),
                      errorWidget: (context, url, error) => Text(
                            "noImage".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                          )),
                ),
                Expanded(
                  child: Text(
                    model.participated_users![index].userName.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    Get.locale!.toLanguageTag().toString() == "tr" ? model.participated_users![index].account_location_tm.toString() : model.participated_users![index].account_location_ru.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
