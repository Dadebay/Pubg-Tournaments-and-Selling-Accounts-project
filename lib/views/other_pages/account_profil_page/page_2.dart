import 'package:game_app/cards/video_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';

class TabbarPage2 extends StatelessWidget {
  final int userID;

  const TabbarPage2({
    required this.userID,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetAccountVideos>>(
      future: GetAccountVideos().getVideos(userID),
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
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return VideoCard(
              image: '$serverURL${snapshot.data![index].poster}',
              videoPath: '$serverURL${snapshot.data![index].video}',
            );
          },
        );
      },
    );
  }
}
