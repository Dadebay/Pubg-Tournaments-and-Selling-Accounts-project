// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/TournamentController.dart';
import 'package:game_app/models/TournamentModel.dart';
import 'package:game_app/views/TournamentPage/TabPage1.dart';
import 'package:game_app/views/TournamentPage/TabPage2.dart';
import 'package:game_app/views/TournamentPage/TabPage3.dart';

class TournamentProfilPage extends StatefulWidget {
  const TournamentProfilPage({
    Key? key,
    required this.tag,
    required this.image,
    required this.tournamentId,
    required this.finised,
  }) : super(key: key);
  final String tag;
  final String image;
  final int tournamentId;
  final bool finised;
  @override
  State<TournamentProfilPage> createState() => _TournamentProfilPageState();
}

class _TournamentProfilPageState extends State<TournamentProfilPage> {
  final ScrollController _sliverScrollController = ScrollController();
  final TournamentController controller = Get.put(TournamentController());
  @override
  void initState() {
    super.initState();
    _sliverScrollController.addListener(() {
      if (!controller.sliverBool.value && _sliverScrollController.hasClients && _sliverScrollController.offset >= 250.0) {
        controller.sliverBool.value = true;
      } else if (controller.sliverBool.value && _sliverScrollController.hasClients && _sliverScrollController.offset <= 130.0) {
        controller.sliverBool.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: kPrimaryColorBlack,
          body: NestedScrollView(
            controller: _sliverScrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [appBar()];
            },
            body: FutureBuilder<TournamentModel>(
                future: TournamentModel().getTournamentID(widget.tournamentId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinKit());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error"));
                  } else if (snapshot.data == null) {
                    return const Center(child: Text("Empty"));
                  }
                  return TabBarView(children: <Widget>[
                    TabPage1(
                      finised: widget.finised,
                      model: snapshot.data!,
                    ),
                    TabPage2(
                      model: snapshot.data!,
                    ),
                    snapshot.data!.participated_users!.isEmpty
                        ? const Center(
                            child: Text("Hic kim gatnasanok"),
                          )
                        : TabPage3(
                            model: snapshot.data!,
                          ),
                  ]);
                }),
          )),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      expandedHeight: 300,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColorBlack,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.white,
        ),
      ),
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: kPrimaryColor,
        labelStyle: const TextStyle(fontFamily: josefinSansSemiBold, fontSize: 20),
        unselectedLabelStyle: const TextStyle(fontFamily: josefinSansMedium, fontSize: 18),
        labelColor: Colors.white,
        isScrollable: widget.finised ? false : true,
        indicatorWeight: 4,
        indicatorPadding: const EdgeInsets.only(
          top: 45,
        ),
        indicator: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            text: "tournamentInfo1".tr,
          ),
          Tab(
            text: "tournamentInfo2".tr,
          ),
          Tab(
            text: widget.finised ? "tournamentInfo3".tr : "tournamentInfo4".tr,
          )
        ],
      ),
      flexibleSpace: Obx(() {
        return AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: SizedBox(
            height: Get.size.height,
            width: Get.size.width,
            child: Hero(
              tag: widget.tag,
              child: CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: widget.image,
                  imageBuilder: (context, imageProvider) => Container(
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => Center(child: spinKit()),
                  errorWidget: (context, url, error) => const Text("No Image")),
            ),
          ),
          crossFadeState: controller.sliverBool.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(seconds: 1000),
          sizeCurve: Curves.decelerate,
          firstCurve: Curves.decelerate,
          secondCurve: Curves.decelerate,
        );
      }),
    );
  }
}
