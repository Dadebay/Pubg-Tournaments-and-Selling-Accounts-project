import 'package:game_app/views/constants/index.dart';

import '../../../models/get_posts_model.dart';

class TabbarPage1 extends StatelessWidget {
  final GetPostsAccountModel model;

  const TabbarPage1({
    required this.model,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        infoPartText('accountDetaile1', model.user!.pubgUsername ?? '', false),
        infoPartText('accountDetaile2', model.user!.pubgId ?? '', false),
        infoPartText('accountDetaile5', model.price!, true),
        infoPartText('accountDetaile6', model.user!.createdDate!.substring(0, 10), false),
        infoPartText('verifed', model.user!.verified == true ? 'yes' : 'no', false),
        infoPartText('posints', model.user!.points.toString(), false),
        infoPartText('points from turnir', model.user!.pointsFromTurnir!.toString(), false),
        infoPartText('Refereal kody', model.user!.referalCode!, false),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 25, top: 15),
          child: Text(
            'accountDetaile11'.tr,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
          ),
        ),
        infoPartText('accountDetaile7', "${model.user!.firsName ?? ""} ${model.user!.lastName ?? ""}", false),
        infoPartText('accountDetaile9', model.user!.phone ?? '', false),
      ],
    );
  }

  Padding infoPartText(String text1, String text2, bool price) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text1.tr,
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontFamily: josefinSansRegular, fontSize: 20),
            ),
          ),
          Expanded(
            child: price
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text2,
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
                    text2,
                    maxLines: 8,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
                  ),
          ),
        ],
      ),
    );
  }
}
