// ignore_for_file: file_names, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_app/cards/VideoCard.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/SettingsController.dart';
import 'package:game_app/models/AccountsForSaleModel.dart';
import 'package:game_app/models/HomePageModel.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountProfilPage extends StatefulWidget {
  final int userID;
  const AccountProfilPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<AccountProfilPage> createState() => _AccountProfilPageState();
}

class _AccountProfilPageState extends State<AccountProfilPage> {
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
                  return const Text("Empty");
                } else if (snapshot.data == null) {
                  return const Text("Error");
                }
                PubgTypes().getTypes().then((value) {
                  for (var element in value) {
                    if (element.id.toString() == snapshot.data!.pubgType.toString()) {
                      Get.find<SettingsController>().pubgType.value = element.title.toString();
                    }
                  }
                });
                Cities().getCities().then((value) {
                  for (var element in value) {
                    if (element.id.toString() == snapshot.data!.location.toString()) {
                      Get.find<SettingsController>().locationName.value = element.name_tm.toString();
                    }
                  }
                });
                return NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [sliverAppBar(snapshot.data!)];
                  },
                  body: tabbarView(snapshot.data!),
                );
              })),
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
        Padding(
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
                        await launch("tel://${model.phone}");
                      },
                      child: Text(
                        'popUP1'.tr,
                        style: const TextStyle(fontFamily: josefinSansRegular),
                      ),
                    ),
                    PopupMenuItem<Text>(
                      onTap: () async {
                        await launch("sms:${model.phone}?body=Pubg House");
                      },
                      child: Text(
                        'popUp2'.tr,
                        style: const TextStyle(fontFamily: josefinSansRegular),
                      ),
                    ),
                  ]),
        ),
      ],
      pinned: true,
      floating: true,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      flexibleSpace: textPart(model),
      bottom: tabar(),
    );
  }

  TabBarView tabbarView(AccountByIdModel model) {
    return TabBarView(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            infoPartText("accountDetaile1", model.pubgUsername ?? "", false),
            infoPartText("accountDetaile2", model.pubgId ?? "", false),
            Obx(() {
              return infoPartText("accountDetaile3", Get.find<SettingsController>().pubgType.value.toString(), false);
            }),
            model.pointsFromTurnir != null ? infoPartText("accountDetaile4", model.pointsFromTurnir ?? "", false) : const SizedBox.shrink(),
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
            model.email != null ? infoPartText("accountDetaile8", model.email ?? "", false) : const SizedBox.shrink(),
            infoPartText("accountDetaile9", model.phone ?? "", false),
            Obx(() {
              return infoPartText("accountDetaile10", Get.find<SettingsController>().locationName.value, false);
            }),
          ],
        ),
        FutureBuilder<List<GetAccountVideos>>(
            future: GetAccountVideos().getVideos(widget.userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.hasError) {
                return const Text("Empty");
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text("Error"));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoCard(
                    image: "$serverURL${snapshot.data![index].poster}",
                    videoPath: "$serverURL${snapshot.data![index].video}",
                  );
                },
              );
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

  FlexibleSpaceBar textPart(AccountByIdModel model) {
    return FlexibleSpaceBar(
      background: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imagePart(model),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Text(
              model.bio ?? "",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: 16),
            ),
          ),
          Container(
            color: kPrimaryColorBlack,
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bolum1(model.price!.substring(0, model.price!.length - 3), "accountPrice".tr, true),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.8),
                  thickness: 1,
                ),
                bolum1(model.pointsFromTurnir!.substring(0, model.pointsFromTurnir!.length - 3), "accountTurnirPoint".tr, false),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.8),
                  thickness: 1,
                ),
                Obx(() {
                  return bolum1(Get.find<SettingsController>().pubgType.value.toString(), "accountPubgType".tr, false);
                }),
              ],
            ),
          ),
          const SizedBox(
            height: kToolbarHeight,
          )
        ],
      ),
    );
  }

  Expanded bolum1(String text1, String text2, bool price) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        price
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text1,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: josefinSansSemiBold,
                      )),
                  const Text(" TMT",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 13,
                        fontFamily: josefinSansSemiBold,
                      )),
                ],
              )
            : Text(
                text1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color: kPrimaryColor, fontSize: 18, fontFamily: josefinSansMedium),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            text2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 17, fontFamily: josefinSansRegular),
          ),
        ),
      ],
    ));
  }

  PreferredSize tabar() {
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
                text: "accountInfo".tr,
              ),
              Tab(
                text: "accountVideos".tr,
              ),
            ]),
      ),
    );
  }

  Expanded imagePart(AccountByIdModel model) {
    return Expanded(
      flex: 4,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 70,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: "$serverURL${model.bgImage ?? ""}",
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
                  errorWidget: (context, url, error) => Image.asset(
                        "assets/images/banner/3.png",
                        fit: BoxFit.cover,
                      )),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColorBlack),
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: CachedNetworkImage(
                          fadeInCurve: Curves.ease,
                          imageUrl: "$serverURL${model.image ?? ""}",
                          imageBuilder: (context, imageProvider) => Container(
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius15,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          placeholder: (context, url) => Center(child: spinKit()),
                          errorWidget: (context, url, error) => Container(
                                color: Colors.white.withOpacity(0.2),
                                child: Center(
                                    child: Text(
                                  "noImage".tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold),
                                )),
                              )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.firsName ?? ""} ${model.lastName ?? ""}",
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            model.phone ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey, fontFamily: josefinSansRegular, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
