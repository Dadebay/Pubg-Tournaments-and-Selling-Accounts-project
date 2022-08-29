// ignore_for_file: file_names

import 'package:game_app/cards/tournament_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/tournament_controller.dart';
import 'package:game_app/models/tournament_model.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final ScrollController scrollCtrl = ScrollController();
  final TournamentController controller = Get.put(TournamentController());
  final ScrollController scrollCtrl1 = ScrollController();
  bool categoryList = false;
  changeState(bool value) {
    categoryList = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.getTournaments = TournamentModel().getTournaments();

    scrollCtrl1.addListener(() {
      if (scrollCtrl1.position.pixels > 10) {
        changeState(true);
      } else if (categoryList == true && scrollCtrl1.position.pixels < 10) {
        changeState(false);
      }
    });
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels > 10) {
        changeState(true);
      } else if (categoryList == true && scrollCtrl.position.pixels < 10) {
        changeState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryColorBlack,
            body: Column(
              children: [
                appbar(),
                tabbar(),
                Expanded(child: Obx(() {
                  print("gelidddddd.................................................................");
                  print(controller.tournamentList);
                  print(controller.tournamentFinisedList);
                  if (controller.tournamentLoading.value == 0) {
                    return noData("cannot_find_data_tournament");
                  } else if (controller.tournamentLoading.value == 1) {
                    return noData("cannot_find_data_tournament");
                  }
                  return TabBarView(children: [
                    controller.tournamentList.isEmpty ? noData("cannot_find_data_tournament") : page1(controller.tournamentList.length),
                    controller.tournamentFinisedList.isEmpty ? noData("cannot_find_data_tournament") : page2(controller.tournamentFinisedList.length),
                  ]);
                })),
              ],
            )),
      ),
    );
  }

  TabBar tabbar() {
    return TabBar(
        labelStyle: const TextStyle(fontFamily: josefinSansSemiBold, fontSize: 20),
        unselectedLabelStyle: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
        labelColor: kPrimaryColor,
        unselectedLabelColor: Colors.grey,
        labelPadding: const EdgeInsets.only(top: 8, bottom: 4),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: kPrimaryColor,
        indicatorWeight: 2,
        tabs: [
          Tab(
            text: "tournament".tr,
          ),
          Tab(
            text: "endTournament".tr,
          ),
        ]);
  }

  Widget page2(int length) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemExtent: 220,
        controller: scrollCtrl1,
        itemCount: length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return TournamentCard(index: index, finised: true, tournamentModel: TournamentModel.fromJson(controller.tournamentFinisedList[index]));
        });
  }

  Widget page1(int length) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemExtent: 220,
        controller: scrollCtrl,
        itemCount: length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return TournamentCard(index: index, finised: false, tournamentModel: TournamentModel.fromJson(controller.tournamentList[index]));
        });
  }

  AnimatedCrossFade appbar() {
    return AnimatedCrossFade(
        firstChild: Container(
          color: kPrimaryColorBlack,
          width: Get.size.width,
        ),
        secondChild: Container(
          padding: const EdgeInsets.only(top: 18, bottom: 15),
          width: Get.size.width,
          decoration: const BoxDecoration(
            color: kPrimaryColorBlack,
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Text(
            "tournament".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: josefinSansSemiBold),
          ),
        ),
        firstCurve: Curves.easeInCubic,
        secondCurve: Curves.fastOutSlowIn,
        crossFadeState: categoryList ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 400));
  }
}
