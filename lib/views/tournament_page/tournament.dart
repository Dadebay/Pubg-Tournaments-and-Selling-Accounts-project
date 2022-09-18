// ignore_for_file: file_names
import 'package:game_app/cards/tournament_card.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/tournament_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/tournament_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final TournamentController controller = Get.put(TournamentController());

  @override
  void initState() {
    super.initState();
    TournamentModel().getTournaments();
    Get.find<WalletController>().getUserMoney();
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
          text: 'tournament'.tr,
        ),
        Tab(
          text: 'endTournament'.tr,
        ),
      ],
    );
  }

  Widget page2(int length) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemExtent: 220,
      itemCount: length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return TournamentCard(index: index, finised: true, tournamentModel: TournamentModel.fromJson(controller.tournamentFinisedList[index]));
      },
    );
  }

  Widget page1(int length) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemExtent: 220,
      itemCount: length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return TournamentCard(index: index, finised: false, tournamentModel: TournamentModel.fromJson(controller.tournamentList[index]));
      },
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await TournamentModel().getTournaments();
    Get.find<WalletController>().getUserMoney();
    setState(() {});

    _refreshController.refreshCompleted();
  }

  // ignore: member-ordering-extended
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            fontSize: 22.0,
            backArrow: false,
            iconRemove: false,
            icon: userAppBarMoney(),
            name: 'tournament',
            elevationWhite: true,
          ),
          backgroundColor: kPrimaryColorBlack,
          body: SmartRefresher(
            footer: footer(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            enablePullUp: false,
            physics: const BouncingScrollPhysics(),
            header: const MaterialClassicHeader(
              color: kPrimaryColor,
            ),
            child: Obx(() {
              if (controller.tournamentLoading.value == 0) {
                return Center(
                  child: spinKit(),
                );
              } else if (controller.tournamentLoading.value == 1) {
                return noData('cannot_find_data_tournament');
              }
              return Column(
                children: [
                  tabbar(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        controller.tournamentList.isEmpty ? noData('cannot_find_data_tournament') : page1(controller.tournamentList.length),
                        controller.tournamentFinisedList.isEmpty ? noData('cannot_find_data_tournament') : page2(controller.tournamentFinisedList.length),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
