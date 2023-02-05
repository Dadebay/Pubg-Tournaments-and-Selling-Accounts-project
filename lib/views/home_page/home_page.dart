import 'package:game_app/views/constants/index.dart';
import 'package:game_app/controllers/home_page_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Banners.dart';
import 'pubg_types.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = Get.put(HomePageController());

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {}
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(fontSize: 0, backArrow: false, iconRemove: true, name: appName, elevationWhite: false),
        body: SmartRefresher(
          footer: footer(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullDown: true,
          enablePullUp: true,
          physics: const BouncingScrollPhysics(),
          header: const MaterialClassicHeader(
            color: kPrimaryColor,
          ),
          child: ListView(
            children: [
              Banners(future: homePageController.futureBanner),
              listViewName('pubgTypes'.tr, false, size),
              PubgTypes(),
              // listViewName('accountsForSale'.tr, true, size),
              // FutureBuilder<List<GetPostsAccountModel>>(
              //   future: GetPostsAccountModel().getVIPPosts(parametrs: {}),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.4)), child: Center(child: spinKit()));
              //     } else if (snapshot.hasError) {
              //       return const Text('error');
              //     } else if (snapshot.data.toString() == '[]') {
              //       return const Text('Empty');
              //     }
              //     return size.width >= 800
              //         ? GridView.builder(
              //             itemCount: snapshot.data!.length,
              //             physics: const NeverScrollableScrollPhysics(),
              //             scrollDirection: Axis.vertical,
              //             shrinkWrap: true,
              //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3 / 4),
              //             itemBuilder: (BuildContext context, int index) {
              //               return HomePageCard(vip: true, model: snapshot.data![index]);
              //             },
              //           )
              //         : ListView.builder(
              //             itemCount: snapshot.data!.length,
              //             physics: const NeverScrollableScrollPhysics(),
              //             scrollDirection: Axis.vertical,
              //             shrinkWrap: true,
              //             itemBuilder: (BuildContext context, int index) {
              //               return HomePageCard(vip: true, model: snapshot.data![index]);
              //             },
              //           );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
