import 'package:game_app/views/constants/index.dart';

import '../cards/best_players_card.dart';

class BestPlayers extends StatelessWidget {
  List userNames = ['XQF Paraboy', 'TGLTN', 'PIO', 'TAIKONN', 'GODV', 'INONIX', 'ScoutOP', 'Jonathan', 'Coffin', 'TQ Marco'];
  List userPoints = [1270, 1154, 1124, 1025, 1012, 950, 930, 756, 654, 521];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: const MyAppBar(fontSize: 0, backArrow: false, iconRemove: true, name: 'bestPlayers2', elevationWhite: true),
      body: Column(
        children: [
          topPart(),
          Expanded(
            child: ListView.builder(
              itemCount: userNames.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return BestPlayersCard(
                  index: index,
                  name: userNames[index],
                  points: userPoints[index].toString(),
                  referalPage: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container topPart() {
    return Container(
      color: kPrimaryColorBlack,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    'No',
                    maxLines: 1,
                    style: TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'userNamePlayers'.tr,
                    maxLines: 1,
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'userNamePlayers2'.tr,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
