// ignore_for_file: missing_return, file_names, must_be_immutable, require_trailing_commas

import 'package:flutter/cupertino.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/add_account_model.dart';

import 'models/index_model.dart';
import 'models/user_models/auth_model.dart';
import 'views/Wallet/wallet_page.dart';
import 'views/add_page/add_account_page.dart';
import 'views/home_page/home_page.dart';
import 'views/tournament_page/tournament.dart';
import 'views/user_profil/user_profil.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  List page = [
    const HomePage(),
    const TournamentPage(),
    Container(),
    const WalletPage(),
    const UserProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: kPrimaryColorBlack,
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              Expanded(
                  child: buttonTop(
                      color: Colors.orange,
                      icon: const Icon(
                        IconlyLight.home,
                        size: 24,
                        color: Colors.white,
                      ),
                      activeIcon: const Icon(
                        IconlyBold.home,
                        size: 24,
                        color: Colors.white,
                      ),
                      name: "bottomNavBar1".tr,
                      index: 0)),
              Expanded(
                  child: buttonTop(
                      color: Colors.orange,
                      icon: Image.asset(
                        "assets/icons/31.png",
                        color: Colors.white,
                        width: 22,
                      ),
                      activeIcon: Image.asset(
                        "assets/icons/3.png",
                        color: Colors.white,
                        width: 22,
                      ),
                      name: "bottomNavBar2".tr,
                      index: 1)),
              Expanded(
                  child: buttonTop(
                      color: Colors.orange,
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        size: 24,
                        color: Colors.white,
                      ),
                      activeIcon: const Icon(
                        CupertinoIcons.add_circled,
                        size: 24,
                        color: Colors.white,
                      ),
                      name: "add".tr,
                      index: 2)),
              Expanded(
                  child: buttonTop(
                      color: Colors.orange,
                      icon: const Icon(
                        IconlyLight.wallet,
                        size: 24,
                        color: Colors.white,
                      ),
                      activeIcon: const Icon(
                        IconlyBold.wallet,
                        size: 24,
                        color: Colors.white,
                      ),
                      name: "Pubg UC",
                      index: 3)),
              Expanded(
                  child: buttonTop(
                      color: Colors.orange,
                      icon: const Icon(
                        IconlyLight.profile,
                        size: 24,
                        color: Colors.white,
                      ),
                      activeIcon: const Icon(
                        IconlyBold.profile,
                        size: 24,
                        color: Colors.white,
                      ),
                      name: "profil".tr,
                      index: 4)),
            ],
          ),
        ),
        body: Center(
          child: page[selectedIndex],
        ));
  }

  Widget buttonTop({required Color color, required Widget icon, required Widget activeIcon, required String name, required int index}) {
    return GestureDetector(
      onTap: () async {
        if (index == 2) {
          final token = await Auth().getToken();
          if (token != null) {
            firstBottomSheet();
          } else {
            showSnackBar("loginError", "add_account_login_error", Colors.red);
          }
        } else {
          setState(() {
            selectedIndex = index;
          });
        }
      },
      child: Column(
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(color: index == selectedIndex ? color : kPrimaryColorBlack, borderRadius: BorderRadius.circular(4)),
          ),
          Expanded(
            child: AnimatedContainer(
              width: double.infinity,
              height: index == selectedIndex ? Get.size.height : 0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                index == selectedIndex ? color.withOpacity(0.005) : Colors.transparent,
                index == selectedIndex ? color.withOpacity(0.3) : Colors.transparent,
                // Colors.indigo,
              ], stops: const [
                0.0,
                0.7
              ], begin: FractionalOffset.bottomCenter, end: FractionalOffset.topCenter, tileMode: TileMode.clamp)),
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Column(
                children: [
                  Expanded(child: index == selectedIndex ? activeIcon : icon),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontFamily: josefinSansRegular, fontSize: index == selectedIndex ? 13 : 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> firstBottomSheet() {
    return Get.bottomSheet(Container(
        decoration: const BoxDecoration(
          borderRadius: borderRadius15,
          color: kPrimaryColorBlack,
        ),
        margin: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            namePart("pubgTypes"),
            customDivider(),
            FutureBuilder<List<PubgTypesModel>>(
              future: PubgTypesModel().getTypes(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                } else if (snapshot.data == null) {
                  return const Center(child: Text("Empty"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Get.back();
                        secondBottomSheet(snapshot.data![index].id!);
                      },
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                      title: Text(
                        snapshot.data![index].title.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        )));
  }

  Padding namePart(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Text(
            text.tr,
            style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 18),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.xmark_circle, size: 24, color: Colors.white),
          )
        ],
      ),
    );
  }

  Future<dynamic> secondBottomSheet(int pubgTypeID) {
    return Get.bottomSheet(Container(
        decoration: const BoxDecoration(
          borderRadius: borderRadius15,
          color: kPrimaryColorBlack,
        ),
        margin: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            namePart("selectCityTitle"),
            customDivider(),
            FutureBuilder<List<Cities>>(
              future: Cities().getCities(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                } else if (snapshot.data == null) {
                  return const Center(child: Text("Empty"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Get.back();
                        thridBottomSheet(pubgTypeID, snapshot.data![index].id!);
                      },
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                      title: Text(
                        Get.locale!.toLanguageTag().toString() == "tr" ? snapshot.data![index].name_tm.toString() : snapshot.data![index].name_ru.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        )));
  }

  Future<dynamic> thridBottomSheet(int pubgTypeID, int locationID) {
    return Get.bottomSheet(Container(
        decoration: const BoxDecoration(
          borderRadius: borderRadius15,
          color: kPrimaryColorBlack,
        ),
        margin: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            namePart("account_type_Vip_or_not"),
            customDivider(),
            FutureBuilder(
              future: AddAccountModel().getConsts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                } else if (snapshot.data == null) {
                  return const Center(child: Text("Empty"));
                }

                return Wrap(
                  children: [
                    ListTile(
                      onTap: () {
                        double b = 0.0;
                        double a = 0.0;
                        if (snapshot.data!["price_for_vip"].toString() != "null") {
                          b = double.parse(snapshot.data!["price_for_vip"]);
                        }
                        if (Get.find<WalletController>().userMoney.toString() != "null") {
                          a = double.parse(Get.find<WalletController>().userMoney.toString());
                        }
                        if (a >= b && a != 0.0) {
                          Get.back();
                          Get.to(() => AddPage(
                                pubgType: pubgTypeID,
                                locationID: locationID,
                                vipOrNot: 0,
                              ));
                        } else if (b >= a) {
                          showSnackBar("money_error_title", "money_error_subtitle", Colors.red);
                        } else {
                          showSnackBar("noConnection3", "tournamentInfo14", Colors.red);
                        }
                      },
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                      title: Text(
                        "price_for_vip".tr + " ${snapshot.data!["price_for_vip"]}" + " TMT",
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        double b = 0.0;
                        double a = 0.0;
                        b = double.parse(snapshot.data!["price_for_vip"].toString());
                        a = double.parse(Get.find<WalletController>().userMoney.toString());
                        if (a >= b) {
                          // Get.back();
                          Get.to(() => AddPage(
                                pubgType: pubgTypeID,
                                locationID: locationID,
                                vipOrNot: 1,
                              ));
                        } else if (b >= a) {
                          showSnackBar("money_error_title", "money_error_subtitle", Colors.red);
                        } else {
                          showSnackBar("noConnection3", "tournamentInfo14", Colors.red);
                        }
                      },
                      trailing: const Icon(
                        IconlyLight.arrowRightCircle,
                        color: Colors.white,
                      ),
                      title: Text(
                        "price_for_not_vip".tr + " ${snapshot.data!["price_for_not_vip"]}" + " TMT",
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: josefinSansMedium,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        )));
  }
}
