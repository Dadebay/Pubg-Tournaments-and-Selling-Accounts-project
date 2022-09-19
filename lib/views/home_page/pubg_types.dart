// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/home_page_model.dart';
import 'package:game_app/views/other_pages/show_all_acconts.dart';

class PubgTypes extends StatelessWidget {
  final Future<List<PubgTypesModel>> future;

  const PubgTypes({
    required this.future,
    Key? key,
  }) : super(key: key);

  Column cannotLoadData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'errorPubgTypes'.tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            PubgTypesModel().getTypes();
          },
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          child: Text(
            'noConnection3'.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansMedium),
          ),
        )
      ],
    );
  }

  GestureDetector circleCard(PubgTypesModel type, Size size) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowAllAccounts(name: type.title!, pubgID: type.id!));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15, top: 15),
        child: Column(
          children: [
            Container(
              width: size.width >= 800 ? 150 : 100,
              height: size.width >= 800 ? 150 : 100,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(color: kPrimaryColorBlack1, shape: BoxShape.circle),
              child: ClipOval(
                child: CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: '$serverURL${type.image}',
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
                  errorWidget: (context, url, error) => Center(child: spinKit()),
                ),
              ),
            ),
            Text(type.title!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, height: 1.3, fontSize: size.width >= 800 ? 25 : 16, fontFamily: josefinSansRegular)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width >= 800 ? 300 : 200,
      margin: const EdgeInsets.only(
        top: 25,
      ),
      color: kPrimaryColorBlack,
      alignment: Alignment.center,
      child: FutureBuilder<List<PubgTypesModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Center(child: spinKit());
              },
            );
          } else if (snapshot.hasError) {
            return cannotLoadData();
          } else if (snapshot.data == null) {
            return cannotLoadData();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return circleCard(snapshot.data![index], size);
            },
          );
        },
      ),
    );
  }
}
