// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';

import 'package:game_app/models/tournament_model.dart';
import '../constants/index.dart';

class TabPage3 extends StatelessWidget {
  final TournamentModel model;
  final bool finised;
  const TabPage3({
    required this.model,
    required this.finised,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: finised ? model.winners!.length : model.participated_users!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          dense: true,
          tileColor: index % 2 == 0 ? kPrimaryColorBlack : kPrimaryColorBlack1,
          minVerticalPadding: 15,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${index + 1}.',
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CachedNetworkImage(
                    fadeInCurve: Curves.ease,
                    imageUrl: finised ? '$serverURL${model.winners![index].account_image}' : '$serverURL${model.participated_users![index].userImage}',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kPrimaryColor),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: const Icon(Icons.info_outline, color: Colors.white),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: const Icon(Icons.info_outline, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  finised ? model.winners![index].account_nickname.toString() : model.participated_users![index].userName.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container cardd(int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            '${index + 1}.',
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CachedNetworkImage(
              fadeInCurve: Curves.ease,
              imageUrl: finised ? '$serverURL${model.winners![index].account_image}' : '$serverURL${model.participated_users![index].userImage}',
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
              placeholder: (context, url) => const Icon(Icons.info_outline, color: Colors.white),
              errorWidget: (context, url, error) => const Icon(Icons.info_outline, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              finised ? model.winners![index].account_nickname.toString() : model.participated_users![index].userName.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
