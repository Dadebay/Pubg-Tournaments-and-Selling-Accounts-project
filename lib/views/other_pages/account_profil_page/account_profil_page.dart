// ignore_for_file: file_names, deprecated_member_use

import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/accouts_for_sale_model.dart';
import 'package:game_app/models/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/index.dart';
import 'page_1.dart';
import 'page_2.dart';
import 'text_part.dart';

class AccountProfilPage extends StatefulWidget {
  final int userID;
  const AccountProfilPage({
    required this.userID,
    Key? key,
  }) : super(key: key);

  @override
  State<AccountProfilPage> createState() => _AccountProfilPageState();
}

class _AccountProfilPageState extends State<AccountProfilPage> {
  dynamic getData(String pubgType, String locationID) {
    // PubgTypesModel().getTypes().then((value) {
    //   for (var element in value) {
    //     if (element.id.toString() == pubgType) {
    //       Get.find<SettingsController>().pubgType.value = element.title.toString();
    //     }
    //   }
    // });
    Cities().getCities().then((value) {
      for (var element in value) {
        if (element.id.toString() == locationID) {
          Get.find<SettingsController>().locationName.value = element.name_tm.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        body: FutureBuilder<AccountByIdModel>(
          future: AccountByIdModel().getAccountById(widget.userID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return noData(
                'account_profil_not_found'.tr,
              );
            } else if (snapshot.data == null) {
              return noData(
                'account_profil_not_found'.tr,
              );
            }
            getData(snapshot.data!.pubgType.toString(), snapshot.data!.location.toString());
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [sliverAppBar(snapshot.data!)];
              },
              body: TabBarView(
                children: [
                  TabbarPage1(
                    model: snapshot.data!,
                  ),
                  TabbarPage2(
                    userID: widget.userID,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverAppBar sliverAppBar(AccountByIdModel model) {
    return SliverAppBar(
      expandedHeight: 500,
      backgroundColor: kPrimaryColorBlack,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 14, left: 14),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle),
          child: const Icon(
            IconlyLight.arrowLeft,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        moreInfoButton(model),
      ],
      pinned: true,
      floating: true,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      flexibleSpace: CustomFlexibleSpace(model: model),
      bottom: tabbar(),
    );
  }

  Padding moreInfoButton(AccountByIdModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 12),
      child: PopupMenuButton(
        color: kPrimaryColorBlack,
        padding: EdgeInsets.zero,
        icon: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle),
          child: const Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        ),
        itemBuilder: (context) => <PopupMenuEntry<Text>>[
          PopupMenuItem<Text>(
            onTap: () async {
              await launch('tel://${model.phone}');
            },
            child: Text(
              'popUP1'.tr,
              style: const TextStyle(fontFamily: josefinSansRegular),
            ),
          ),
          PopupMenuItem<Text>(
            onTap: () async {
              await launch('sms:${model.phone}?body=Pubg House');
            },
            child: Text(
              'popUp2'.tr,
              style: const TextStyle(fontFamily: josefinSansRegular),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize tabbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColorBlack,
          border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
        ),
        child: TabBar(
          labelStyle: const TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 18),
          unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 17, fontFamily: josefinSansRegular),
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: kPrimaryColor,
          indicatorWeight: 4,
          indicatorPadding: const EdgeInsets.only(
            top: 45,
          ),
          indicator: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          tabs: [
            Tab(
              text: 'accountInfo'.tr,
            ),
            Tab(
              text: 'accountVideos'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
