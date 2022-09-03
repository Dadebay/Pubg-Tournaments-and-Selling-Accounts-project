import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';

class TabbarPage1 extends StatelessWidget {
  const TabbarPage1({Key? key, required this.model}) : super(key: key);
  final AccountByIdModel model;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        infoPartText("accountDetaile1", model.pubgUsername ?? "", false),
        infoPartText("accountDetaile2", model.pubgId ?? "", false),
        Obx(() {
          return infoPartText("accountDetaile3", Get.find<SettingsController>().pubgType.value.toString(), false);
        }),
        infoPartText("accountDetaile5", model.price!.substring(0, model.price!.length - 3), true),
        infoPartText("accountDetaile6", model.createdDate!.substring(0, 10), false),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 25, top: 15),
          child: Text(
            "accountDetaile11".tr,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
          ),
        ),
        infoPartText("accountDetaile7", "${model.firsName ?? ""} ${model.lastName ?? ""}", false),
        infoPartText("accountDetaile9", model.phone ?? "", false),
        Obx(() {
          return infoPartText("accountDetaile10", Get.find<SettingsController>().locationName.value, false);
        }),
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
                      Text(text2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: josefinSansSemiBold,
                          )),
                      const Text(" TMT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: josefinSansSemiBold,
                          )),
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
