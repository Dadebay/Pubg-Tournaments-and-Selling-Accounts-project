// ignore_for_file: missing_return, file_names, must_be_immutable, require_trailing_commas

import 'package:game_app/buttons/bottom_nav_bar_button.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/controllers/wallet_controller.dart';
import 'package:game_app/models/add_account_model.dart';

import 'constants/dialogs.dart';
import 'models/index_model.dart';
import 'models/user_models/auth_model.dart';
import 'views/add_page/add_account_page.dart';
import 'views/home_page/home_page.dart';
import 'views/tournament_page/tournament.dart';
import 'views/user_profil/user_profil.dart';
import 'views/wallet/wallet_two_part.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<WalletController>().getUserMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: kPrimaryColorBlack,
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 0,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(0),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: true,
                index: 1,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(1),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 2,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(2),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 3,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(3),
              )),
              Expanded(
                  child: BottomNavbarButton(
                icon: false,
                index: 4,
                selectedIndex: selectedIndex,
                onTapp: () => onTapp(4),
              )),
            ],
          ),
        ),
        body: Center(
          child: page[selectedIndex],
        ));
  }

  void onTapp(int index) async {
    Get.find<SettingsController>().agreeButton.value = false;

    if (index == 2) {
      final token = await Auth().getToken();
      if (token != null) {
        defaultBottomSheet(name: 'pubgTypes', child: getTypess());
      } else {
        showSnackBar('loginError', 'add_account_login_error', Colors.red);
      }
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  FutureBuilder<List<PubgTypesModel>> getTypess() {
    return FutureBuilder<List<PubgTypesModel>>(
      future: PubgTypesModel().getTypes(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return noData('tournamentInfo14');
        } else if (snapshot.data == null) {
          return noData('tournamentInfo14');
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Get.back();
                defaultBottomSheet(name: 'selectCityTitle', child: getCitiess(snapshot.data![index].id!));
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
    );
  }

  FutureBuilder<List<Cities>> getCitiess(int pubgTypeID) {
    return FutureBuilder<List<Cities>>(
      future: Cities().getCities(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.data == null) {
          return const Center(child: Text('Empty'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Get.back();
                defaultBottomSheet(name: 'account_type_Vip_or_not', child: getConstss(pubgTypeID, snapshot.data![index].id!));
              },
              trailing: const Icon(
                IconlyLight.arrowRightCircle,
                color: Colors.white,
              ),
              title: Text(
                Get.locale!.toLanguageTag().toString() == 'tr' ? snapshot.data![index].name_tm.toString() : snapshot.data![index].name_ru.toString(),
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
    );
  }

  FutureBuilder<dynamic> getConstss(int pubgTypeID, int locationID) {
    return FutureBuilder<dynamic>(
      future: AddAccountModel().getConsts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: spinKit());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.data == null) {
          return const Center(child: Text('Empty'));
        }

        return Wrap(
          children: [
            ListTile(
              onTap: () {
                double b = 0.0;
                double a = 0.0;
                if (snapshot.data!['price_for_vip'].toString() != 'null') {
                  b = double.parse(snapshot.data!['price_for_vip']);
                }
                if (Get.find<WalletController>().userMoney.toString() != 'null') {
                  a = double.parse(Get.find<WalletController>().userMoney.toString());
                }
                if (a >= b && a != 0.0) {
                  Get.back();
                  Get.to(() => AddPage(
                        pubgType: pubgTypeID,
                        locationID: locationID,
                        vipOrNot: 1,
                      ));
                } else if (b >= a) {
                  showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                } else {
                  showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                }
              },
              trailing: const Icon(
                IconlyLight.arrowRightCircle,
                color: Colors.white,
              ),
              title: Text(
                'price_for_vip'.tr + " ${snapshot.data!["price_for_vip"]}" + ' TMT',
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
                b = double.parse(snapshot.data!['price_for_not_vip'].toString());
                a = double.parse(Get.find<WalletController>().userMoney.toString());
                if (a >= b) {
                  Get.to(() => AddPage(
                        pubgType: pubgTypeID,
                        locationID: locationID,
                        vipOrNot: 0,
                      ));
                } else if (b >= a) {
                  showSnackBar('money_error_title', 'money_error_subtitle', Colors.red);
                } else {
                  showSnackBar('noConnection3', 'tournamentInfo14', Colors.red);
                }
              },
              trailing: const Icon(
                IconlyLight.arrowRightCircle,
                color: Colors.white,
              ),
              title: Text(
                'price_for_not_vip'.tr + " ${snapshot.data!["price_for_not_vip"]}" + ' TMT',
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
    );
  }
}
