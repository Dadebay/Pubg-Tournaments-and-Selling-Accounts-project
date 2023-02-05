import 'package:game_app/views/constants/index.dart';

import '../../cards/best_players_card.dart';

class ReferalPage extends StatelessWidget {
  const ReferalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColorBlack,
      appBar: MyAppBar(
        fontSize: 0,
        backArrow: true,
        iconRemove: false,
        icon: IconButton(
          onPressed: () {
            showSnackBar('referalKod', 'referalSubtitle', Colors.green);
          },
          icon: const Icon(
            Icons.info_outline,
            color: kPrimaryColor,
          ),
        ),
        name: 'referalKod',
        elevationWhite: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: kPrimaryColorBlack,
            width: Get.size.width,
            padding: const EdgeInsets.only(top: 12, left: 10),
            child: Text(
              'referalKod1'.tr,
              style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? 30 : 22, fontFamily: josefinSansSemiBold),
            ),
          ),
          Container(
            color: kPrimaryColorBlack,
            padding: const EdgeInsets.only(left: 10, top: 8),
            child: Row(
              children: [
                const Text(
                  'JKHB186GKIFP158',
                  style: TextStyle(fontFamily: josefinSansBold, fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: 'JKHB186GKIFP158')).then((value) {
                      showSnackBar('copySucces', 'copySuccesSubtitle', Colors.green);
                    });
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          dividder(),
          Container(
            color: kPrimaryColorBlack,
            width: Get.size.width,
            padding: const EdgeInsets.only(top: 12, left: 10, bottom: 25),
            child: Text(
              'referalKodUsedUser'.tr,
              style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? 30 : 22, fontFamily: josefinSansSemiBold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (BuildContext context, int index) {
                return BestPlayersCard(
                  index: index,
                  name: 'Pubg ady',
                  points: '0.2',
                  referalPage: true,
                  image: '',
                );
              },
            ),
          ),
          dividder(),
          Container(
            color: kPrimaryColorBlack,
            padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'referalKodEarnedMoney'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 24),
                  ),
                ),
                const Expanded(
                  child: Text(
                    '0 TMT',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: kPrimaryColor, fontFamily: josefinSansBold, fontSize: 24),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container dividder() {
    return Container(
      color: kPrimaryColorBlack,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}
