// ignore_for_file: file_names, avoid_print

import 'package:flutter_html/flutter_html.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/models/tournament_model.dart';
import 'package:game_app/models/user_models/user_sign_in_model.dart';

import '../../models/user_models/auth_model.dart';

class TabPage1 extends StatelessWidget {
  final bool finised;
  final String buttonName;
  final TournamentModel model;

  const TabPage1({Key? key, required this.finised, required this.buttonName, required this.model}) : super(key: key);
  checkStatus() async {
    final token = await Auth().getToken();
    TournamentModel().checkStatus(tournamentID: model.id!, value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kPrimaryColorBlack,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  model.title!,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 26),
                ),
              ),
              twoText(name1: "tournamentInfo5".tr, name2: model.mode ?? ""),
              twoText(name1: "tournamentInfo6".tr, name2: model.map ?? ""),
              twoText(name1: "tournamentInfo7".tr, name2: model.start_date!.substring(0, 9)),
              twoText(name1: "tournamentInfo8".tr, name2: finised ? "tournamentInfo9".tr : "tournamentInfo10".tr),
              const SizedBox(
                height: 25,
              ),
              Html(data: Get.locale?.languageCode == "tr" ? model.description_tm ?? "" : model.description_ru ?? "", style: {
                "body": Style(fontFamily: josefinSansRegular, fontSize: const FontSize(18.0), color: Colors.white70, textAlign: TextAlign.left),
              }),
              const SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
        finised
            ? const SizedBox.shrink()
            : Positioned(
                left: 25,
                right: 25,
                bottom: 15,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: borderRadius25,
                  ),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onPressed: () async {
                    final token = await Auth().getToken();
                    print(token);
                    if (buttonName == "Kody görkez") {
                      checkStatus();
                    } else {
                      if (token != null && token != "") {
                        subscribeTurnir();
                      } else {
                        showSnackBar("loginError", "loginErrorTurnir", Colors.red);
                      }
                    }
                  },
                  child: Text(
                    buttonName.tr,
                    style: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 22),
                  ),
                ),
              )
      ],
    );
  }

  subscribeTurnir() {
    Get.defaultDialog(
        title: "correctData".tr,
        backgroundColor: kPrimaryColorBlack,
        titleStyle: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        radius: 15,
        titlePadding: const EdgeInsets.only(top: 15),
        content: FutureBuilder<GetMeModel>(
            future: GetMeModel().getMe(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else if (snapshot.data == null) {
                return const Center(child: Text("Empty"));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "correctData1".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
                    ),
                  ),

                  //Get my account etmeli
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 8),
                    child: Text(
                      "accountDetaile1".tr + " ${snapshot.data!.nickname}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "accountDetaile2".tr + " ${snapshot.data!.pubgId}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
                    ),
                  ),
                  // ignore: unnecessary_null_comparison
                  if (model.price.toString() != "null")
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
                      child: Text(
                        "accountDetaile5".tr + " ${model.price} TMT",
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 20),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  AgreeButton(onTap: () {
                    TournamentModel().participateTournament(tournamentID: model.id!).then((value) {
                      if (value == 200) {
                        Get.back();
                        showSnackBar("tournamentInfo18", "WetournamentInfo17", kPrimaryColor);
                      } else {
                        Get.back();
                        showSnackBar("noConnection3", "tournamentInfo19", Colors.red);
                      }
                    });
                  }),
                ],
              );
            }));
  }

  Padding text(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        name.tr,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 18,
          fontFamily: josefinSansRegular,
        ),
      ),
    );
  }

  Padding twoText({required String name1, required String name2}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name1.tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontFamily: josefinSansRegular,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              name2.tr,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontFamily: josefinSansSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
