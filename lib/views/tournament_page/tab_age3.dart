// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournament_model.dart';

class TabPage3 extends StatelessWidget {
  const TabPage3({Key? key, required this.model, required this.finised}) : super(key: key);
  final TournamentModel model;
  final bool finised;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: finised ? model.winners!.length : model.participated_users!.length,
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
                      imageUrl: finised ? "$serverURL${model.winners![index].account_image}" : "$serverURL${model.participated_users![index].userImage}",
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
                      errorWidget: (context, url, error) => Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColorBlack1.withOpacity(0.4),
                        ),
                        child: const Icon(Icons.info_outline, color: Colors.white),
                      ),
                    )),
                Expanded(
                  child: Text(
                    finised ? model.winners![index].account_nickname.toString() : model.participated_users![index].userName.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
