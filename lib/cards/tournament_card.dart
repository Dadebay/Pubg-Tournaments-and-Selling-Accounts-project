// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournament_model.dart';
import 'package:game_app/views/tournament_page/tournament_profil_page.dart';

class TournamentCard extends StatelessWidget {
  final int index;
  final bool finised;
  final TournamentModel tournamentModel;
  const TournamentCard({Key? key, required this.index, required this.tournamentModel, required this.finised}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TournamentProfilPage(
              tag: "$serverURL${tournamentModel.image}",
              finised: finised,
              image: "$serverURL${tournamentModel.image}",
              tournamentId: tournamentModel.id!,
            ));
      },
      child: Container(
        width: Get.size.width,
        margin: EdgeInsets.only(top: index == 0 ? 15 : 0, bottom: 12, right: 12, left: 12),
        decoration: const BoxDecoration(color: kPrimaryColorBlack, borderRadius: borderRadius30),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: borderRadius30,
                child: Hero(
                  tag: "$serverURL${tournamentModel.image}",
                  child: CachedNetworkImage(
                      fadeInCurve: Curves.ease,
                      imageUrl: "$serverURL${tournamentModel.image}",
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(decoration: BoxDecoration(borderRadius: borderRadius30, color: kPrimaryColorBlack.withOpacity(0.55))),
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: finised ? EdgeInsets.zero : const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(finised ? "endTournament".tr : tournamentModel.title!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 28)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(tournamentModel.start_date!.substring(0, 10), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontFamily: josefinSansRegular, fontSize: 18)),
                      ),
                      Text(tournamentModel.start_date!.substring(11, 16), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontFamily: josefinSansRegular, fontSize: 18)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
